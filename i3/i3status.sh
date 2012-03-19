#!/bin/sh
# shell script to prepend i3status with more stuff

i3status -c ~/.i3/i3status.volume.conf | while :
do
    read i3StatusLine 

    # get the current mpd line
    currentTrack=`mpc current`
    if [ "x" != "x${currentTrack}" ]; then
        currentTrack="${currentTrack}^fg(#333333)^p(5;-2)^ro(2)^p()^fg()^p(5)"
    fi

    # status from irssi
    irssiStatus=`cat ~/.irssi_status`
    if [ "x" != "x${irssiStatus}" ]; then
        irssiStatus="^fg(#00FF00)irssi: ${irssiStatus}^fg(#333333)^p(5;-2)^ro(2)^p()^fg()^p(5)"
    fi

    # new mails
    mails=`ls ~/Mail/nsn/INBOX/new/ | wc -l`
    if [ "0" != "${mails}" ]; then
        mails="^fg(#00FF00)mails: ${mails}^fg(#333333)^p(5;-2)^ro(2)^p()^fg()^p(5)"
    else
        mails=""
    fi

    # put it together
    echo "${currentTrack}${irssiStatus}${mails}${i3StatusLine}"
done
