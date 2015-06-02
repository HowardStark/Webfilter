# Webfilter for Mac OS X

Webfilter is a simple command line tool for circumventing workplace or school webfilters. It is written in Bash and requires Admin priveledges to run.

## Installation

YOU NEED SUPER USER PRIVELEDGES!!1!

### Normal Installation

To install the Webfilter tool, start by downloading the .bash_profile including in this repository. The next step is to check if you already have a .bash_profile file. Type `ls ~/.bash_profile` into terminal. If it outputs, `No such file or directory`, continue through this section. If not, skip to the Advanced section.

If it outputs, `No such file or directory`, you're in the clear. Simply move the .bash_profile file into your home directory. After moving the .bash_profile file into your home directory, type `source ~/.bash_profile`.

Now you need to start configuring. Currently, there is only one area for configuration, and it is the desired server. Go into the .bash_profile file in your favorite editor, locate `user@example.com` and replace that with your desired proxy host. Now your almost done!

To test it, type `webfilter` into the command line. It should return `Please run as root. Usage: webfilter [on/off]`. If this is the case, then your next step is to start using it. Type `webfilter on` to turn the tool on. It will prompt you for your admin password twice, then in the command line, it will prompt you for your server password. Once you hit enter, it won't do anything, it will just hang. You're done! 

### Advanced Installation

If you are at this section, it means that `ls ~/.bash_profile` returned `~/.bash_profile`. This means you already have an existing .bash_profile file. Not to worry though! Simply open the downloaded .bash_profile file in your favorite editor, copy the entire file, then exit out. Now edit the existing .bash_profile and insert the copied contents at the bottom of the existing .bash_profile file. 

Now type `source ~/.bash_profile`, then refer to the beginner tutorial for testing. Enjoy!




