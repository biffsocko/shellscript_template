# shellscript_template
<pre>
A general template for shell scripts that incorporates 
logging, 
debug mode, 
checking for the existance of files, 
error checking for commands issued in the script, 
verifying root user if necessary
printing help or usage function


example:


main(){
    start                             # log that the program is starting
    chkroot                           # verify that root is running the the script
    chkerror_exit "ls -l /foo"        # ls -l /foo - or exit if the command fails
    finish                            # log that the program is finishing and exit
  }  
  
  
  everything else is handled in the functions
  </pre>
