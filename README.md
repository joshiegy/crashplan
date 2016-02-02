# Crashplan

First run:
* Expl. docker run -v <your configdir>:/config/ -v <folder to backup>:/media/ -p 4242:4242/tcp -p 4243:4243/tcp --name crashplan -tid joshiegy/crashplan

* Exam. docker run -v /mnt/docker/crashplan/config/:/config/ -v /media/:/media/ -p 4242:4242/tcp -p 4243:4243/tcp --name crashplan -tid joshiegy/crashplan

# Access by pointing your local crashplaninstallation to host-ip instead of localhost.
See more here: https://www.liquidstate.net/how-to-manage-your-crashplan-server-remotely/
* Alt:

# Install crashplan on your desktop
Install the docker-crashplan-rockstor-plugin
run "docker log crashplan" to get an output with a line containing a line with portnumber,UID,IP. Copy that to your desktopinstall of crashplan under /var/lib/crashplan/.ui_info (Windows: C:\ProgramData\CrashPlan.ui_info)
Volumes:
/config = where all config-files and caches will be stored outside of the container
/media = Files to backup, more can be provided if neccessary.

Portforward 4242 from outside to host-ip:4242 if client-to-client back is used. Not needed for use with crashplan cloud.


The "linker.sh" is copied from an outside source with no lisence attached - if you are the original author - please contact me and I'll update this to tribute your work.


A big thank you to Code42 for excellent software!
