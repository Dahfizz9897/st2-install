#!/bin/bash


get_dependencies() {
    apt update && apt upgrade -y

    apt install python3-pip python3-virtualenv python3-dev build-essential libffi-dev -y

    apt install mongodb mongodb-server -y
    apt install rabbitmq-server -y
}

get_st2() {
    git clone https://github.com/StackStorm/st2.git
    cd st2
    git submodule update --init --recursive
    make requirements
}

make_stanley() {
    mkdir -p /home/stanley/.ssh
    useradd -d /home/stanley stanley
    ssh-keygen -f /home/stanley/.ssh/stanley_rsa -t rsa -b 4096 -C "stanley@stackstorm.com" -N ''
}


echo "updating packages and downloading dependencies"
get_dependencies || exit 1

echo "Downloading st2 code and building"
get_st2 || exit 1

echo "Making Stanley user"
make_stanley || exit 1
