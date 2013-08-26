#/bin/sh
VERSION=1.1
REPO_PATH=$(dirname $(readlink -f $0));
# This is the place where the setup will be installed
INSTALL_DIR=/usr/local/lamp_dev_64 ;


####################### Utility Functions #######################
log () {

   date_str=`date '+%Y-%m-%d %H:%M:%S'`;
   mode="info"
   if [ -z "$2" ] ;
   then
      mode=info
   else
      mode=$2
   fi
   echo "[$date_str][$mode] $1";

}
#################################################################


# First of all we should check that who is running the script
# If its not root then exit now only
if [ `whoami` != "root" ]; then
   log "This script must be run as root :)" "error";
   exit 1
fi


# Check to see if the install dir already exists
if [ -d "$INSTALL_DIR" ]; then
   log "Install dir already exists" "error"; 
   log "You should remove the dir($INSTALL_DIR) to begin installation " "error"; 
else
   # Create the dir first
   mkdir -p $INSTALL_DIR
   if [ "$?" = "0" ]; then
      log "Created dir $INSTALL_DIR";
      cd $REPO_PATH;

      log "Moving configurations folder first"
      cp -r etc "$INSTALL_DIR/etc"; 
      log "And the scripts folder.."
      cp -r scripts "$INSTALL_DIR/scripts";

      log "Installing all the dependencies";
      log "This step make use of internet connection and it will take few minutes :)";
      apt-get update >/dev/null 2>/dev/null;
      yes | apt-get install bison libncurses5-dev libtool g++ gcc make cmake libssl-dev libexpat1-dev zlib1g-dev libpng-dev libjpeg-dev libxml2-dev libcurl4-openssl-dev libmcrypt-dev libmhash-dev libxslt-dev libneon27-gnutls-dev >/dev/null  2>/dev/null

      # Installing Mysql
      log "Installing Mysql .."
      cp -r mysql "$INSTALL_DIR/mysql";
      log "Adding mysql user and group"
      groupadd mysql; useradd -g mysql mysql;
      log "Changing ownership of mysql installation";
      chown -R root "$INSTALL_DIR/mysql" ; chgrp -R mysql "$INSTALL_DIR/mysql";chown -R mysql "$INSTALL_DIR/mysql/data"
      log "Putting system data into mysql"
      cd $INSTALL_DIR/mysql;
      $INSTALL_DIR/mysql/scripts/mysql_install_db --user=mysql >/dev/null
      cd $REPO_PATH
      #@TODO to put all the executables into path

    
      # Installing apache
      log "Installing Apache .."
      cp -r apache "$INSTALL_DIR/apache";
      log "Adding apache user and group"
      groupadd apache; useradd -g apache apache; 
      log "Changing ownership of apache installation"
      chown -R root "$INSTALL_DIR/apache" ; chgrp -R apache "$INSTALL_DIR/apache";chown -R apache "$INSTALL_DIR/apache/logs"
      #@TODO to put all the executable into path 
      
      # Installing mongodb
      log "Installing Mongodb .."
      cp -r mongodb "$INSTALL_DIR/mongodb";
      log "Changing ownership of mongo installation"
      chown -R root.root "$INSTALL_DIR/mongodb"
      #@TODO to put all the executable into path

      # Installing memcached
      log "Installing memcached .."
      cp -r memcache "$INSTALL_DIR/memcache";
      log "Changing ownership of memcache installation"
      chown -R root.root "$INSTALL_DIR/memcache"
      #@TODO to put all the executable into path

      # Installing php
      log "Installing php with gd,mongodb,memcache and xdebug drivers.."
      cp -r php "$INSTALL_DIR/php";
      cp -r gd "$INSTALL_DIR/gd"
      log "Changing ownership of php installation"
      chown -R root.root "$INSTALL_DIR/php"
      chown -R root.root "$INSTALL_DIR/gd"
      #@TODO to put all the executable into path

      # Installing phpmyadmin
      log "Installing phpmyadmin .."
      cp -r phpmyadmin "$INSTALL_DIR/phpmyadmin";
      log "Changing ownership of php installation"
      chown -R root.root "$INSTALL_DIR/phpmyadmin"

      # Installing jdk 1.7
      log "Installing Jdk .."
      cp -r jdk "$INSTALL_DIR/jdk";
      log "Changing ownership of jdk installation"
      chown -R root.root "$INSTALL_DIR/jdk"

      # Installing all init scripts
      log "Copying init scripts .."
      cp -r init.d "$INSTALL_DIR/init.d";
      log "Changing ownership of init.d scripts and insuring they remain executable"
      chown -R root.root "$INSTALL_DIR/init.d";
      chmod -R 755 $INSTALL_DIR/init.d

      # Installing all rc.d scripts
      log "Installing all system startup scripts"
      cp -r rc.d "$INSTALL_DIR/rc.d";
      log "Changing ownership of rc.d scripts and insuring they are working"
      chown -R root.root "$INSTALL_DIR/rc.d";
      chmod -R 755 $INSTALL_DIR/rc.d

      #Installation complete now starting the system for the first time
      # Starting system
      log "Starting lamp stack for the first time..";
      $REPO_PATH/scripts/start_lamp_first
      log "Few or all of the servers started";

      
      log " ";
      date_str=`date '+%Y-%m-%d %H:%M:%S'`
      log "Would you like to install few init scripts in your system.??".
      log "These scripts help get up your lamp stack when you start your machine or"
      log "Stop down safely when you shutdown your system. You SHOULD NOT install them if you"
      log "are already using any other lamp stack otherwise they will conflict with each other."
      read -p "[$date_str][info] Do you want to install scripts[y/n]:" install_sripts;

      if [ "$install_sripts" = "y" -o "$install_sripts" = "Y" ]; then
         # Putting rc.d start files into system directory
         ln -s $INSTALL_DIR/rc.d/start_lamp /etc/rc2.d/S81start_lamp
         # Putting rc.d stop files into system directory
         ln -s $INSTALL_DIR/rc.d/stop_lamp /etc/rc0.d/K19stop_lamp
         log "rc.d scripts installed"
      else
         log "rc.d scripts installation defferred"
      fi      

      log "You can always start the server by running"
      log "$INSTALL_DIR/init.d/lampctl start"
      log "And stop the server by running"
      log "$INSTALL_DIR/init.d/lampctl stop"
      log " "
      log " "
      log "Would you like to share your email with us please."
      log "We will be happy to see that some body is using our work :)"
      log "If you don't want to share, just press enter."
      date_str=`date '+%Y-%m-%d %H:%M:%S'` 
      read -p "[$date_str][info] Enter email:" email;
      wget http://pisystems.co.in/install_lamp_dev?action=i\&email=$email\&ver=$VERSION\&host=`hostid` >/dev/null 2>/dev/null        
      
      log " "
      log " "
      log "Thanks for installing this system, your system is successfully installed"
      log " "
      log "Created by Tejaswi Sharma <tej.nri@gmail.com>"
      log "Please feel free to contact me in case of any problem or bug"
      log "Also please do send me your feedback on the above email id"
      log "File your bug here if you want: http://code.google.com/p/crucible-platform/issues/list"
   else
	log "Cannot create install directory!" "error"
        log "File your bug here if you want: http://code.google.com/p/crucible-platform/issues/list"
	exit 1
   fi
fi


