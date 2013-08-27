#/bin/sh
INSTALL_DIR=/usr/local/lamp_dev_64
BIN_DIR=$INSTALL_DIR/bin

set_path ( ) {
  CURRENT_PATH=`pwd`
  BIN_PATH=$1;
  cd $BIN_PATH;
  
  for file in * ; do
    rm $BIN_DIR/$file 2>/dev/null
    ln -s `pwd`/$file $BIN_DIR/$file ;
  done ;
  cd $CURRENT_PATH;
}

rm -rf $INSTALL_DIR/bin >/dev/null 2>/dev/null
mkdir $INSTALL_DIR/bin >/dev/null
if [ "$?" = 0 ]; then
  # Put php executables in path
  set_path $INSTALL_DIR/php/bin
  # Put mysql executables in path
  set_path $INSTALL_DIR/mysql/bin
  # Put Mongodb executable in path
  set_path $INSTALL_DIR/mongodb/bin
  # Put apache executable in path
  set_path $INSTALL_DIR/apache/bin
  # Put Mongodb executable in path
  set_path $INSTALL_DIR/mongodb/bin
  # Put Mongodb executable in path
  set_path $INSTALL_DIR/jdk/bin
  exit 0;
else
  exit 1;
fi
