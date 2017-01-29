#!/bin/bash
ls -R /cs/home/tkt_cam/public_html/2011/11

# The same, but only list jpgs (not even the directories that contain them: this is how I understood the assignment)
ls -R /cs/home/tkt_cam/public_html/2011/11 | grep '.*.jpg'

# Now count the pictures
ls -R /cs/home/tkt_cam/public_html/2011/11 | grep '.*.jpg' | wc -l

