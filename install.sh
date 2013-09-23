#/bin/sh
VERSION=1.1
REPO_PATH=$(dirname $(readlink -f $0));
# This is the place where the setup will be installed
INSTALL_DIR=/usr/local/cruciform ;

#echo $REPO_PATH/lib/slib/utility.sh;
. $REPO_PATH/lib/slib/utility.sh

# First of all we should check that who is running the script
# If its not root then exit now only
if [ `whoami` != "root" ]; then
   log "This script must be run as root :)" $ERROR;
   exit 1
fi

machine=`uname -p`
if [ $machine != "x86_64" ]; then
   log "This system is not 64 bit. Cannot install :(" $ERROR;
   exit 1
fi

# Check to see if the install dir already exists
if [ -d "$INSTALL_DIR" ]; then
   log "Install dir already exists" $WARN; 
   log "You should remove the dir($INSTALL_DIR) to begin installation" $ERROR; 
else
   # Create the dir first
   mkdir -p $INSTALL_DIR
   if [ "$?" = "0" ]; then
      log "Created dir $INSTALL_DIR";
      cd $REPO_PATH;

      log "Installing all the dependencies";
      log "This step make use of internet connection and it will take few minutes :)";
      apt-get update >/dev/null 2>/dev/null;
      yes | apt-get install bison libncurses5-dev libtool g++ gcc make cmake libssl-dev libexpat1-dev zlib1g-dev libpng-dev libjpeg-dev libxml2-dev libcurl4-openssl-dev libmcrypt-dev libmhash-dev libxslt-dev libneon27-gnutls-dev libmemcached-dev libxpm-dev vim >/dev/null  2>/dev/null

      # Copying bin folder
      log "Copying all the components folder"
      cp -r lib "$INSTALL_DIR/lib";

      # Copying bin folder
      log "Copyiny bin folder"
      cp -r bin "$INSTALL_DIR/bin";

      # Copying init.d folder
      log "Copyiny init.d folder"
      cp -r init.d "$INSTALL_DIR/init.d";

      # Copying rc.d folder
      log "Copyiny rc.d folder"
      cp -r rc.d "$INSTALL_DIR/rc.d";
      

      # Managing configurations
      log "Checking configurations folder"
      if [ -d /etc/cruciform ]; then
         log "Configurations directory already exists" $WARN
         log "Putting all the old configurations into folder /etc/cruciform/original"
         rm -rf /etc/cruciform/original >/dev/null 2>/dev/null
         cp -r /etc/cruciform /tmp/original
         rm -rf /etc/cruciform/*
         cp -r /tmp/original /etc/cruciform/original
         rm -rf /tmp/original
         log "Finally copying configurations for the fresh install";
         cp -r etc/* /etc/cruciform 
      else
         log "Copying configurations for the fresh install";
         cp -r etc /etc/cruciform        
      fi   

      #Installing mysql
      log "Installing mysql .."
      log "Adding mysql user and group"
      groupadd cp-mysql; useradd -g cp-mysql cp-mysql;
      log "Changing ownership of mysql installation";
      chown -R root "$INSTALL_DIR/lib/mysql" ; chgrp -R cp-mysql "$INSTALL_DIR/lib/mysql"; 
      
      log "Checking for previous mysql install"
      if [ -d /var/lib/cruciform/mysql ]; then
         read_input "Would you like to keep your old db in your new installation[y/n]"
         if [ "$RETURN" != "y" -a "$RETURN" != "Y" ]; then 
            log "Backing up mysql data into folder /var/lib/cruciform/mysql.old"
            rm -rf /var/lib/cruciform/mysql.old
            mv /var/lib/cruciform/mysql /var/lib/cruciform/mysql.old       
            log "Creating mysql data dir /var/lib/cruciform/mysql"
            mkdir -p /var/lib/cruciform/mysql
            log "Installing initial data.."
            cd $INSTALL_DIR/lib/mysql
            ./scripts/mysql_install_db --user=cp-mysql --datadir=/var/lib/cruciform/mysql --basedir=$INSTALL_DIR/lib/mysql >/dev/null 2>/dev/null
            chown -R cp-mysql.cp-mysql /var/lib/cruciform/mysql >/dev/null 2>/dev/null
         else
            log "Not touching the old dbs. Please make sure they are are in good condition :)"          
         fi
      else
         log "No previous mysql .."
         log "Creating mysql data dir /var/lib/cruciform/mysql"
         mkdir -p /var/lib/cruciform/mysql
         log "Installing initial data.."
         cd $INSTALL_DIR/lib/mysql
         ./scripts/mysql_install_db --user=cp-mysql --datadir=/var/lib/cruciform/mysql --basedir=$INSTALL_DIR/lib/mysql >/dev/null 2>/dev/null 
         chown -R cp-mysql.cp-mysql /var/lib/cruciform/mysql >/dev/null 2>/dev/null
      fi
      log "Putting mysql bin directory into path"
      set_env_var PATH $INSTALL_DIR/lib/mysql/bin
      
      #log "Staring mysql .."
      #$INSTALL_DIR/bin/mysqlctl start >/dev/null
    
      # Installing apache
      log "Installing Apache .."
      log "Adding apache user and group"
      groupadd cp-apache; useradd -g cp-apache cp-apache; 
      log "Changing ownership of apache installation"
      chown -R root "$INSTALL_DIR/lib/apache" ; chgrp -R cp-apache "$INSTALL_DIR/lib/apache";chown -R cp-apache "$INSTALL_DIR/lib/apache/logs"
      log "Putting apache bin directory into path"
      set_env_var PATH $INSTALL_DIR/lib/apache/bin

      #log "Starting apache .."
      #$INSTALL_DIR/bin/apachectl start
      
      # Installing mongodb
      log "Installing Mongodb .."
      log "Changing ownership of mongo installation"
      chown -R root.root "$INSTALL_DIR/lib/mongodb"

      log "Checking for previous mongodb install"
      if [ -d /var/lib/cruciform/mongodb ]; then
         read_input "Would you like to keep your old mongodb databases in your new installation[y/n]"
         if [ "$RETURN" != "y" -a "$RETURN" != "Y" ]; then
            log "Backing up mongod data into folder /var/lib/cruciform/mongodb.old"
            rm -rf /var/lib/cruciform/mongodb.old
            mv /var/lib/cruciform/mongodb /var/lib/cruciform/mongodb.old
            log "Creating mongodb data dir /var/lib/cruciform/mongodb"
            mkdir -p /var/lib/cruciform/mongodb
         else
            log "Not touching the old dbs. Please make sure they are are in good condition :)"
         fi
      fi
      log "Putting monodb bin directory into path"
      set_env_var PATH $INSTALL_DIR/lib/mongodb/bin

      #log "Starting mongod .."
      #$INSTALL_DIR/bin/mongoctl start

      # Installing memcached
      log "Installing memcached .."
      log "Changing ownership of memcache installation"
      chown -R root.root "$INSTALL_DIR/lib/memcached"
      log "Putting memcached bin directory into path"
      set_env_var PATH $INSTALL_DIR/lib/memcached/bin 
     
      #log "Starting memcache .."
      #$INSTALL_DIR/bin/memcachectl start      

      # Installing php
      log "Installing php with gd,mongodb,memcache and xdebug drivers.."
      log "Changing ownership of php installation"
      chown -R root.root "$INSTALL_DIR/lib/php"
      chown -R root.root "$INSTALL_DIR/lib/misc/gd"

      log "Putting php bin directory into path"
      set_env_var PATH $INSTALL_DIR/lib/php/bin

      # Installing phpmyadmin
      #log "Installing phpmyadmin .."
      #cp -r phpmyadmin "$INSTALL_DIR/phpmyadmin";
      #log "Changing ownership of php installation"
      #chown -R root.root "$INSTALL_DIR/phpmyadmin"

      # Installing jdk 1.7
      log "Installing Jdk .."
      chown -R root.root "$INSTALL_DIR/lib/jdk"
      log "Putting jdk bin directory into path"
      set_env_var PATH $INSTALL_DIR/lib/jdk/bin

      # Installing ant
      log "Installing Ant .."
      chown -R root.root "$INSTALL_DIR/lib/ant"
      log "Putting ant bin directory into path"
      set_env_var PATH $INSTALL_DIR/lib/ant/bin


      # Installing node.js
      log "Installing node.js .."
      chown -R root.root "$INSTALL_DIR/lib/node.js"
      log "Putting node.js bin directory into path"
      set_env_var PATH $INSTALL_DIR/lib/node.js/bin

      # Installing all init and bin scripts
      log "Changing ownership of init.d and bin scripts and insuring they remain executable"
      chown -R root.root "$INSTALL_DIR/init.d"  "$INSTALL_DIR/bin";
      chmod -R 755 $INSTALL_DIR/init.d $INSTALL_DIR/bin

      # Installing all rc.d scripts
      log "Installing all system startup scripts"
      log "Changing ownership of rc.d scripts and insuring they are working"
      chown -R root.root "$INSTALL_DIR/rc.d";
      chmod -R 755 $INSTALL_DIR/rc.d

      #Installation complete now starting the system for the first time
      #Starting system
      log "Starting lamp stack for the first time..";
      $REPO_PATH/lib/slib/start_lamp_first
      log "Few or all of the servers started";

      
      #log " ";
      #date_str=`date '+%Y-%m-%d %H:%M:%S'`
      #log "Would you like to install few init scripts in your system.??".
      #log "These scripts help get up your lamp stack when you start your machine or"
      #log "Stop down safely when you shutdown your system. You SHOULD NOT install them if you"
      #log "are already using any other lamp stack otherwise they will conflict with each other."
      #read -p "[$date_str][info] Do you want to install scripts[y/n]:" install_sripts;

      #if [ "$install_sripts" = "y" -o "$install_sripts" = "Y" ]; then
      #   # Putting rc.d start files into system directory
      #   ln -s $INSTALL_DIR/rc.d/start_lamp /etc/rc2.d/S81start_lamp
      #   # Putting rc.d stop files into system directory
      #   ln -s $INSTALL_DIR/rc.d/stop_lamp /etc/rc0.d/K19stop_lamp
      #   log "rc.d scripts installed"
      #else
      #   log "rc.d scripts installation defferred"
      #fi      

      #log "You can always start the server by running"
      #log "$INSTALL_DIR/init.d/lampctl start"
      #log "And stop the server by running"
      #log "$INSTALL_DIR/init.d/lampctl stop"
      #log " "
      #log " "
      #log "Would you like to share your email with us please."
      #log "We will be happy to see that some body is using our work :)"
      #log "If you don't want to share, just press enter."
      #date_str=`date '+%Y-%m-%d %H:%M:%S'` 
      #read -p "[$date_str][info] Enter email:" email;
      #wget http://pisystems.co.in/install_lamp_dev?action=i\&email=$email\&ver=$VERSION\&host=`hostid` >/dev/null 2>/dev/null        
      
      #log " "
      #log " "
      #log "Thanks for installing this system, your system is successfully installed"
      #log " "
      #log "Created by Tejaswi Sharma <tej.nri@gmail.com>"
      #log "Please feel free to contact me in case of any problem or bug"
      #log "Also please do send me your feedback on the above email id"
      #log "File your bug here if you want: http://code.google.com/p/crucible-platform/issues/list"
   else
      log "Cannot create install directory!" "error"
      log "File your bug here if you want: http://code.google.com/p/crucible-platform/issues/list"
      exit 1
   fi
fi


