#!/bin/bash
#set -x

e_info() {
    printf "$(tput setaf 38)→ %s$(tput sgr0)\n" "$@"
}

start_job(){

    # ---------------------------------
    # nginx
     e_info "------- 启动nginx -------"

     ser=`/usr/bin/pgrep nginx`
     if [ "$ser" != "" ]
     then
         e_info "nginx exist! I will reload it. "
         sudo /usr/local/bin/nginx -s stop
     fi

     sudo -S /usr/local/bin/nginx
     e_info "nginx start success!"


    # ---------------------------------
    # php
     e_info "------- 启动php -------"

     ser=`/usr/bin/pgrep php-fpm`
     if [ "$ser" != "" ]
     then
         e_info "php-fpm exist! I will reload it. "
         sudo killall php-fpm
     fi

     sudo -S /usr/local/php5.6/sbin/php-fpm
     e_info "php-fpm 56 start success!"

    # ---------------------------------
    # mysql
     e_info "------- 启动mysql -------"

     ser=`/usr/bin/pgrep mysql`
     if [ "$ser" != "" ]
     then
         e_info "mysql exist! I will reload it. "
          brew services restart mysql@5.7
     else
          brew services start mysql@5.7
         e_info "mysql start success!"
     fi

    # ---------------------------------
    # redis
     e_info "------- 启动redis -------"

     ser=`/usr/bin/pgrep redis`
     if [ "$ser" != "" ]
     then
         e_info "redis exist! I will reload it. "
          brew services restart redis

     else
         sudo brew services start redis
          "redis start success!"
     fi

    # e_info "------- 启动memcacheq -------"
    # ser=`/usr/bin/pgrep memcacheq`
    # if [ "$ser" != "" ]
    # then
    #     e_info "memcacheq exist! I will reload it. "
    #     sudo killall memcacheq
    # fi

    # /usr/local/bin/memcacheq -d -r -uroot -p11212 -H /usr/local/memcacheq/data -N -R -v -L 32KB -B 2048 > /tmp/mq_error.log 2>&1
    # e_info "memcacheq start success!"


    # e_info "------- 启动mongodb -------"

    # ser=`/usr/bin/pgrep mongo`
    # if [ "$ser" != "" ]
    # then
    #     e_info "mongodb exist! I will reload it. "
    #     brew services restart mongodb-community@4.2

    # else
    #     brew services start mongodb-community@4.2
    #      "mongodb start success!"
    # fi

    e_info "OK"

}

stop_job(){

    # ---------------------------------
    # nginx
    e_info "------- 结束nginx -------"

    ser=`/usr/bin/pgrep nginx`
    if [ "$ser" != "" ]
    then
        sudo /usr/local/bin/nginx -s stop
    fi
    e_info "nginx stop success!"

    # ---------------------------------
    # php
    e_info "------- 结束php -------"

    ser=`/usr/bin/pgrep php-fpm`
    if [ "$ser" != "" ]
    then
        sudo killall php-fpm
    fi
    e_info "php stop success!"

    # ---------------------------------
    # mysql
    # e_info "------- 结束mysql -------"


    # ser=`/usr/bin/pgrep mysql`
    # if [ "$ser" != "" ]
    # then
    #     sudo brew services stop mysql@5.6
    # fi
    # e_info "mysql stop success!"

    # ---------------------------------
    # redis
    # e_info "------- 结束redis -------"
    # ser=`/usr/bin/pgrep redis`
    # if [ "$ser" != "" ]
    # then
    #     e_info "redis exist! I will reload it. "
    #     sudo brew services stop redis
    # fi
    # e_info "redis stop success!"


    #sudo -S /usr/local/opt/php@7.1/sbin/php-fpm
    #e_info "php-fpm 71 start success!"

    # ---------------------------------
    # redis
   

}


# --------- main ---------

if [ "$1"x = "stop"x ]; then
        stop_job
    else
        start_job
fi


# show_help_and_exit() {
# cat <<HELP
# 请指定版本
# eg:
#     phpinit [54|56|71]
# HELP
#     exit -1
# }

# if [ $# -lt 1 ]
# then
#     show_help_and_exit
# fi

# ##启动nginx
# ser=`/usr/bin/pgrep nginx`
# if [ "$ser" != "" ]
# then
#     echo "nginx exist! I will reload it. "
#     sudo /usr/local/bin/nginx -s stop
# fi
# sudo -S /usr/local/bin/nginx
#     echo "nginx start success!"

# ##启动php-fpm
# ser=`/usr/bin/pgrep php-fpm`
# if [ "$ser" != "" ]
# then
#     echo "php-fpm exist! I will reload it. "
#     sudo killall php-fpm
# fi
# sudo -S /usr/local/opt/"php"$1/sbin/php-fpm
#     echo "php-fpm start success!"
