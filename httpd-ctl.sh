#!/bin/bash
set -e
set -o pipefail
port=8080
# dir="/home/parasup/IdeaProjects/special_topics/docker-lab1/www"
dirarg="-v $PWD:/usr/local/apache2/htdocs/"
while getopts 'h?p:d:' OPTION; do
  case "$OPTION" in
    p)
      port="$OPTARG"
      echo "you entered $port"
      ;;

    h)
      echo "script usage: $(basename $0) <-p port> <-h> <-d directory> <start|stop|destroy>"
      exit 0
      ;;

    d)
      dirarg="-v $OPTARG:/usr/local/apache2/htdocs/"
      echo "The dir value provided is: $dirarg"
      ;;
    ?)
      echo "script usage: $(basename $0) <-p port> <-h> <-d directory> <start|stop|destroy>"
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"
# echo "arguments at the end are: $1 and: $2"
if [ -z "$1"  ]
then
   echo "you must enter start stop or destroy as the last parameter"
   exit 1
else
   if [ $1 == "start" ]
   then
      echo "starting my-apache-app"
      (docker stop my-apache-app) || true
      (docker rm my-apache-app) || true
      docker run -dit --name my-apache-app -p $port:80 $dirarg httpd:2.4
      # docker start  my-apache-app
   else
	   if [ $1 == "stop" ]
	   then
	      echo "stopping my-apache-app"
	      (docker stop my-apache-app) || true
	   else
		   if [ $1 == "destroy" ]
		   then
		      echo "destroying my-apache-app"
		      (docker stop my-apache-app) || true
                      (docker rm my-apache-app) || true
	           else
			   echo "invalid argument at end"
			   exit 1
		   fi
	   fi
   fi
fi
# echo docker run -dit --name my-apache-app -p $port:80 $dirarg httpd:2.4
