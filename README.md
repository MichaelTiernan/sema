# Introduction

## sema 
`sema` is a utility to create, delete, raise, wait on a named semaphore.

# Licence
This program is distributed under the GPL version 2 license.
See the file INSTALL for installation instructions.

# Examples

If one script wants to wait until another script has executed some steps, the following pattern could be used.

### A.sh 
~~~sh
#!/bin/sh

echo A.sh started
sema -c S1
./B.sh &
echo A.sh more work
echo waiting for B.sh to finish
sema -w S1
echo B.sh finished execution
echo A.sh do more work
# cleanup semaphores
sema -d S1
~~~

### B.sh
~~~sh
#!/bin/sh

echo Hello from B.sh
sleep 5
sema -r S1
echo Bye bye from B.sh
~~~

# Troubleshooting:
If a shell script fails and leaves a semaphore with negative values, it is not possible to delete it.
In that case, raise the value of semaphore by raising it manually by executing `sema -r S1` and then delete it using `sema -d S1`
