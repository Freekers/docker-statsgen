# Statsgen 2 as Docker
Statsgen 2 is a Statistics Generator for Call Of Duty 1/2/4/5, MOHAA, Spearhead, Wolfenstein/Enemy Territory and Quake Wars. Statsgen automatically downloads the server logfiles, processes them using a flexible template system, and then transmits the resultant webpages to the webserver. Templating allows the pages produced to be very flexible to fit in with the style of your clan website.

# Configuration
This is not your typical Docker image, as it does not contain Statsgen 2 itself. It's merely a preconfigured base image for Statsgen 2 to run in headless mode using Wine.

Before you can use/run the image, you need to perform a one-time configuration, which sets up the Statsgen 2 .ini file, templates and directory structure.

To do so, you first need to [download Statsgen 2 to your local computer](https://github.com/Freekers/statsgen/releases/download/v1.9.3/statsgen2_v1.9.3.zip). Statsgen2 can be run on Windows (native) or on Linux using Wine. If you're on Linux, you probably need to use `winetricks` to install `vcrun6`.

- Unzip the contents of the zipfile to a known location, for example C:\statsgen2
- Next, open statsgen2.exe and go to Run --> First Time Configuration and follow the onscreen prompts.
- You can choose to either run the Statsgen2 Docker on the gameserver itself or FTP the logfiles over, if you're planning on running the Statsgen2 Docker on a remote ('homepc') machine.   
Should you run this Docker container on the same machine as the gameserver, uncomment the volume mount pointing to your gameserver's logfile.
- Make sure to complete the entire setup wizard, including the upload of the image packs.
- Once the setup wizard is done, you return to the main application screen. Feel free to change the sttings more to your liking, for example change the run schedule. 
- When you're done, close Statsgen 2.
- Now open the statsgen2.ini file with a text editor such as Notepad(++) and find/replace all directories with the following location: `Z:\root\statsgen\drive_c\statsgen`
- Save the file and copy over the **entire** statsgen2 directory, i.e. C:\statsgen2, to your Docker host, for example `/opt/statsgen2`.   
Make sure to update the path accordingly in the docker-compose.yml.

# Run
Use the included docker-compose.yml to start the container.

# Updating/changing the Configuration
If you need to change anything to your statsgen2.ini configuration file, make sure to stop the Docker container first before doing so.

# Advanced Usage using crontab
If you want, you can use cron to schedule Statsgen2 to run. To do so, add the following line to your docker-compose.yml: `command: -runonce`  
This will cause statsgen to start, perform a stats run, then exit and thus the container will stop.  
Make sure to remove  `restart: always` from the compose file as well, else it will keep restarting infitenly.

Schedule the Docker using `crontab -e` as follows:  
`33 3 * * * /usr/local/bin/docker-compose -f /opt/statsgen2/docker-compose.yml start > /dev/null`

# Acknowledgements
[Statsgen 2](http://statsgen.co.uk) by Shaun Jackson  
[docker-wine-vcrun6](https://github.com/telyn/docker-wine-vcrun6) by telyn