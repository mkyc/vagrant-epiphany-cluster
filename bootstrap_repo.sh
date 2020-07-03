#!/bin/bash

echo "OK repo"
whoami

#dirty hack for now
systemctl enable httpd
systemctl start httpd
