#!/bin/bash

# for i in /etc/update-motd.d/*; do if [ "$i" != "/etc/update-motd.d/99-fsck-at-reboot" ]; then $i; fi; done

#!/bin/bash
#this script runs all motd files, intended if update-motd does not work

find -maxdepth 1 -name '[[:digit:]]*' | while read files; do
	$files
done

