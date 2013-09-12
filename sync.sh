#!/bin/bash - 
#===============================================================================
#
#          FILE: sync.sh
# 
#         USAGE: ./sync.sh 
# 
#   DESCRIPTION: Sends the file i'm working on in clouddesktop to vagrant server
# 
#       OPTIONS: filename i'm synching with server
#  REQUIREMENTS: Clouddesktop repo
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Diaa Kasem
#  ORGANIZATION: 
#       CREATED: 08/20/13 15:19:23 EET
#      REVISION:  0.1
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#!/bin/bash
filename="$@";
# scp "$filename" 'user@192.168.123.123:/home/user/clouddesktop/clouddesktop-appcatalog'${PWD#$(hg root)}/"$filename"
echo 'user@192.168.123.123:/home/user/clouddesktop/clouddesktop-appcatalog'${PWD#$(hg root)}/"$filename"
scp "$filename" 'user@192.168.123.123:/home/user/clouddesktop/clouddesktop-appcatalog'${PWD#$(hg root)}/"$filename"
