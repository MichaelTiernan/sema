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

echo "${0} started"

# Create a semaphore and call it 'S1'
sema -c S1

# Now launch a child task.
./B.sh &

# Pretend we're doing work...
echo "${0} more work"
echo "waiting for B.sh to finish"

# Ask to wait on the semaphore we created before.
sema -w S1

# If we arrive here, the semaphore said the wait is over.
echo "B.sh finished execution"
echo "${0} do more work"

# Always clean up after yourself.
# cleanup semaphores
sema -d S1
~~~

### B.sh
~~~sh
#!/bin/sh

# From the begining of this script's tasks, "A"
# is waiting on the semephore it created and will
# patiently wait until this script finishes.
echo "Hello from B.sh"
sleep 5

# Now, this script asks the semaphone to raise meaning
# "I'm done" letting the next train run.
sema -r S1
echo Bye bye from B.sh
~~~

# Troubleshooting:
If a shell script fails and leaves a semaphore with negative values, it is not possible to delete it.
In that case, raise the value of semaphore by raising it manually by executing `sema -r S1` and then delete it using `sema -d S1`
