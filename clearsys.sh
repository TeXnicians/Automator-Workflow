# !/bin/sh

# clear noise files
cd /System/Library/Speech/
rm -rf Voices/*

# clear log files
rm -rf /private/var/log/*

# clear temp files
cd /private/var/tmp/
rm -rf TM*

# clear cache files
cd ~/Library/Caches/
rm -rf ~/Library/Caches/*

