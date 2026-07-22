# Shell Utility Script Collection

## A collection of handy sysadmin scripts in both bash and PowerShell languages

### Overview
Here you can find all the simple bash and PowerShell scripts that I have created over time. These are scripts that I use on a daily basis to automate my workflow and make it more efficient. I have written more, but some include trade secrets from my current employer and I am choosing to keep them private for their protection. 

I've created this collection to track all the scripts I have created over time with the plan to modify them as I learn more. It also serves as a backup for this toolbox. Lastly, I wanted to share them with the world. 

Some are simple scripts running basic instructions, like initializing executable documents. Others are much more specific to certain tasks, like automating Google searches. I have learned over time that the less lines of code used, the more efficient the script works. The ones I am proudest of are only 2 - 3 lines of code. 

### Script Explanations

 - `date.ps1`
A simple PowerShell script that gets the current date and exact time with seconds. I use this often for logging documentation and ticket entries.

- `google.sh`
One of my favorites! It enables the possibility to google from the terminal, taking any number of parameters as search terms and opening the link for each given keyword. 

In earlier versions, it only took a single argument and I would manually loop through arrays of search terms. I realized later how backwards this method was is and modified it. The current approach allows a user to input any number of parameters, without having to write a single loop. 

- `iniexe.sh`
The ultimate "lazy admin" script. Enter the file name as a parameter to create a new shell script in the current directory. It automatically makes the file and executable with `chmod +x`, and `chmod 755` to set the file permissions so that the owner can read, write, and execute.