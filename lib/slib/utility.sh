#/bin/sh
RED=1
GREEN=2
YELLOW=3;
BLUE=4

NORMAL=0;
BOLD=1;
UNDERLINE=4;

write_in_color () {
   txt=$1
   color=$2;
   decoration=$3

   case "$color" in
      "$RED") txt="$(tput setaf 1)$txt$(tput sgr0)"
         ;;
      "$GREEN") txt="$(tput setaf 2)$txt$(tput sgr0)"
         ;;
      "$YELLOW") txt="$(tput setaf 3)$txt$(tput sgr0)"
         ;;
      "$BLUE") txt="$(tput setaf 4)$txt$(tput sgr0)"
         ;;
      *) txt="$(tput setaf 7)$txt$(tput sgr0)"
         ;;
   esac

   case "$decoration" in
      "$NORMAL") txt="$txt"
         ;;
      "$BOLD") txt="$(tput bold)$txt"
         ;;
      "$UNDERLINE") txt="$(tput ser 0 1)$txt"
         ;;
      *) txt="$txt"
         ;;
   esac
   
   printf "$txt"
}

write_in_color_line () {
   write_in_color "$1" "$2" "$3"
   echo "";
}

INFO=info
ERROR=error
WARN=warn

log () {
   date_str=`date '+%Y-%m-%d %H:%M:%S'`;
   mode="info"
   if [ -z "$2" ] ;
   then
      mode=info
   else
      mode=$2
   fi
   log_str="[$date_str][$mode] $1";
   case "$mode" in
      $INFO) write_in_color_line "$log_str" $GREEN $NORMAL
            ;;
      $ERROR)  write_in_color_line "$log_str" $RED $BOLD
            ;;
      $WARN) write_in_color_line "$log_str" $YELLOW $BOLD
            ;;
      *) write_in_color_line "$log_str" $BLUE $NORMAL
            ;;
   esac

}

RETURN=;
read_input () {
   RETURN=
   date_str=`date '+%Y-%m-%d %H:%M:%S'`;
   input_str="[$date_str][input] $1";
   write_in_color "$input_str" $BLUE $NORMAL
   read -p ":" input
   RETURN=$input;
}

set_env_var () {
   env_var=$1;
   env_var_value=$2;
   final_var_value="`$INSTALL_DIR/lib/slib/put_env_vars $env_var $env_var_value`"
   export $env_var=$final_var_value 
}
