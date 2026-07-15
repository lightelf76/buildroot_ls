Infomatika T113base 
====================
Base configuration for the number of Infomatika boards,
based on the Allwinner T113-S3 dual core CPU

How to build
============

$ make infomatika_t113base_defconfig
$ make

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX
