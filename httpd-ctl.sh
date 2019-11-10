#!/bin/bash
set -e
set -o pipefail
port=8080
dir="/c/parasup/2019/cscc/java/special_topics/linux-docker-lab/docker-lab1/www"
while getopts 'h?p:d:' OPTION; do
  case "$OPTION" in
    p)
      port="$OPTARG"
      echo "you entered $port"
      ;;

    h)
      echo "script usage: $(basename $0) <-p port> <-h> <-d directory>"
      ;;

    d)
      dir="$OPTARG"
      echo "The dir value provided is: $dir"
      ;;
    ?)
      echo "script usage: $(basename $0) <-p port> <-h> <-d directory>"
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"
# echo "arguments at the end are: $1 and: $2"
echo $port
echo "$dir"
echo docker run -dit --name my-apache-app-2 -p $port:80 -v --force-recreate $dir:/usr/local/apache2/htdocs/ httpd:2.4
docker run -dit --name my-apache-app-2 -p $port:80 -v --force-recreate "$dir":/usr/local/apache2/htdocs/ httpd:2.4
