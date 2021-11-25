# Tests

## *`test-sema-wait1`*

When run, `test-sema-wait1` returns a sequence like this:

```
 ...
Who goes first is 1
 ...
```

Then after a short delay, test 1 will be released.

The important part of this is that the test numbers alternate 1,2,1,2... etc.
The first one released should be "who goes first" from above.

The ordinal numbers are meaningless but illustrate the inability for this test to rule the order they come out at.

```
test 1 released 0 and running 'pidvalue'.
test 2 released 0 and running 'pidvalue'.
test 1 released 1 and running 'pidvalue'.
test 2 released 3 and running 'pidvalue'.
test 1 released 3 and running 'pidvalue'.
test 2 released 4 and running 'pidvalue'.
test 1 released 7 and running 'pidvalue'.
test 2 released 6 and running 'pidvalue'.
test 1 released 6 and running 'pidvalue'.
test 2 released 5 and running 'pidvalue'.
test 1 released 4 and running 'pidvalue'.
test 2 released 10 and running 'pidvalue'.
test 1 released 11 and running 'pidvalue'.
test 2 released 8 and running 'pidvalue'.
test 1 released 10 and running 'pidvalue'.
test 2 released 7 and running 'pidvalue'.
test 1 released 5 and running 'pidvalue'.
test 2 released 2 and running 'pidvalue'.
test 1 released 2 and running 'pidvalue'.
test 2 released 12 and running 'pidvalue'.
test 1 released 12 and running 'pidvalue'.
test 2 released 11 and running 'pidvalue'.
test 1 released 8 and running 'pidvalue'.
test 2 released 9 and running 'pidvalue'.
test 1 released 9 and running 'pidvalue'.
test 2 released 1 and running 'pidvalue'.
```
# *`test-sema-wait2a`* and *`test-sema-wait2b`*

The semaphores protect the file that stores the report number.

The first, `test-sema-wait2a` shows the same operation without the semaphores.
The numbers are all over the place.

```
Waiting for jobs.
Generating report number R000074
Generating report number R000075
Generating report number R000076
Generating report number R000001
Generating report number R000001
Generating report number R000077
Generating report number R000077
Generating report number R000002
Generating report number R000002
Generating report number R000002
All background tasks done. Cleaning up.
```

The second `test-sema-wait2b` uses the seamaphore to lock the file
before it is read/written so that no two jobs are using it at the same
time.
(File number reset to 78 for this test.)

```
Waiting for jobs.
Generating report number R000079
Generating report number R000080
Generating report number R000081
Generating report number R000082
Generating report number R000083
Generating report number R000084
Generating report number R000085
Generating report number R000086
Generating report number R000087
Generating report number R000088
All background tasks done. Cleaning up.
```

