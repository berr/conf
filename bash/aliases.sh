#! /bin/bash

launch() {
    nohup "$@" < /dev/null 2> /dev/null > /dev/null &!
}
