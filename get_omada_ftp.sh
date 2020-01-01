#!/bin/bash
ftp -nvp ftp.rent-a-guru.de <<EOF
    quote USER anonymous
    quote PASS user@email.com
    cd /private
    get omada-controller_3.2.1-1_all.deb
    bye
EOF
