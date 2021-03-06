#!/usr/bin/env sh

DISPLAY=`[ "$OSTYPE" == "msys" ] && echo "-display gtk" || echo "-nographic"`

qemu-system-aarch64                                                         \
    -machine virt                                                           \
    -cpu cortex-a57                                                         \
    -m 256M                                                                 \
    -smp 1                                                                  \
    $DISPLAY                                                                \
    -drive if=pflash,file=flash0.img,format=raw                             \
    -drive if=pflash,file=flash1.img,format=raw                             \
    -drive if=none,file=debian-9.2.1-arm64-hd.qcow2,id=hd0                  \
    -device virtio-blk-device,drive=hd0                                     \
    -drive if=none,file=debian-9.2.1-arm64-netinst.iso,media=cdrom,id=cdrom \
    -device virtio-scsi-device                                              \
    -device scsi-cd,drive=cdrom                                             \
    -netdev user,hostfwd=tcp::2222-:22,id=eth0                              \
    -device virtio-net-device,netdev=eth0
