zpool create tank mirror disk1 disk2
zpool set autoreplace=on

zpool offline tank disk
PARTED GPT
sgdisk --replicate 
random disk identifier
zpool replace tank disk newdisk

