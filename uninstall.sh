#/bin/sh

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


log "Initiating uninstall";
# Check to see if the install dir already exists
if [ -d "$INSTALL_DIR" ]; then
   log "Stopping all services first.."
   $REPO_PATH/scripts/stop_lamp_uninstall   
   
   log "Removing the install dir"
   rm -rf $INSTALL_DIR

   log "Removing rc.d startup scripts"
   rm /etc/rc2.d/S81start_lamp /etc/rc0.d/K19stop_lamp >/dev/null 2>/dev/null

   log "Removing added users and groups"
   userdel apache; userdel mysql;

   log "You have got your system cleaned like a egg now :)"

else
   log "Install dir not present. May be you have not installed the system at all"
   log "Or you have just deleted the install dir."
   log "In case you have deleted the install dir and wanted to stop the remaining services"
   log "run: $REPO_PATH/rc.d/stop_lamp";
   log "If you want to install again:"
   log "run: $REPO_PATH/install.sh"
fi

log " "
log " "
log "Created by Tejaswi Sharma <tej.nri@gmail.com>"
log "Please send me your experience at the above address";


