# crashplan
Crashplan RockOn for Rockstor


First run:
* Expl. docker run -v <your configdir>:/config/ -v <folder to backup>:/media/ -p 4242:4242/tcp -p 4243:4243/tcp --name crashplan -tid joshiegy/crashplan

* Exam. docker run -v /mnt/docker/crashplan/config/:/config/ -v /media/:/media/ -p 4242:4242/tcp -p 4243:4243/tcp --name crashplan -tid joshiegy/crashplan

<H1>Access by pointing your local crashplaninstallation to host-ip instead of localhost. </H1>
See more here: https://www.liquidstate.net/how-to-manage-your-crashplan-server-remotely/
* Alt:

<H1> Install crashplan on your desktop </H1>
Install the docker-crashplan-rockstor-plugin
run "docker log crashplan" to get an output with a line containing a line with portnumber,UID,IP. Copy that to your desktopinstall of crashplan under /var/lib/crashplan/.ui_info (Windows: C:\ProgramData\CrashPlan.ui_info)
Volumes:
/config = where all config-files and caches will be stored outside of the container
/media = Files to backup, more can be provided if neccessary.

Portforward 4242 from outside to host-ip:4242 if client-to-client back is used. Not needed for use with crashplan cloud.
