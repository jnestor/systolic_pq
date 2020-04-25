# systolic_pq
systolic_pq is a  SystemVerilog implementation of Lieserson's Systolic Priority
Queue described in the CMU Computer Science Department Tech Report "Systolic
Priority Queues (Report Number CMU-CS-79-115, April 1979)".  Currently this
implements the "Simple Systolic Priority Queue" described in Section 3 of
the report.

## Usage

This implementation is parameterized by bitwidth of the key (KW) and bitwidth
of the value (VW).  The keys are implemented as unsigned integers with the
smallest value ('0) reserved to represent "negative infinity" and the largest
value ('1) reserved to represent "positive infinity".  Entries in the
priority queue are sorted from minimum to maximum, with the minimum value
available on the odata port.

To insert a value, assert the value to be written on idata and assert ivalid=1.
The insertion will start on the rising edge where irdy=ivalid=1.

To extract a value, read the value on the and wait for ovalid=1.
When this occurs, assert ordy to initiate the removal of the minimum
value.

## Implementation Notes

This is a straightforward implementation of the "Simple Systolic Priority
Queue" described in Lieserson's CMU-CS Tech report a few variations:

1. The interface is implemented using valid-ready interfaces for
insertion and removal.  As in the orignal, insertion removal
may only be initiated on "even" clock cycles.

2. In Lieserson's original description, each systolic processor Pi operates in
two steps: 1) shift the "B" register (i.e. Bi = Bi-1); 2) Sort the values in
A-i, Ai, and Bi so that Ai-1 <= Ai <= Bi).  In this implementation the two steps
are combined and occur in a single clock cycle.

3. The priority queue output is read directly from the "A" output of the
P1 processor.  An extract operation removes this value but unlike
Lieserson's original description it does not place the removed value
in the "A" register of processor P0.  Instead it reads the value
before it is removed.

Insert operations may be initiate on any even clock cycle except when
an extract operation is being initiatied.  However, if the
inserted value is a minimum value it will not appear on the data output until
the beginning of the next even clock cycle since an odd cycle is required to
place the result in the "A" register of Processor P1.

Extract operations may be initiatied on any even clock cycle where
an insert operation is taking place
Write operations have a latency of two cycles since an even cycle is required
to start the operation and an odd cycle is required to store the result in the
"A" register of processor P1.

Extract operations have a latency of three clock cycles - they are initiated
on an even cycle by inserting an "Inifinite" value into the pipeline which
will appear on the output during the next even clock cycle.  The correct value
is available on the next even clock cycle.
