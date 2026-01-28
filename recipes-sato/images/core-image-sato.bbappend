fix_grub_for_initrd_serial () {
    GRUBCFG="${IMAGE_ROOTFS}/boot/EFI/BOOT/grub.cfg"
 
    if [ -f "$GRUBCFG" ]; then
        bbnote "Fixing GRUB: root=/dev/ram0, ttyS4, initrd, radeon, HDMI"
 
        # Remove LABEL=boot completely
        sed -i 's|\<LABEL=boot\>||g' "$GRUBCFG"
 
        # Force root to /dev/ram0
        sed -i 's|root=/dev/sda[0-9]*|root=/dev/ram0|g' "$GRUBCFG"
 
        # Remove VGA console
        sed -i 's|console=tty0||g' "$GRUBCFG"
 
        # Force serial console to ttyS4
        sed -i 's|console=ttyS[0-9]*|console=ttyS4|g' "$GRUBCFG"
        sed -i 's|console=ttys[0-9]*|console=ttyS4|g' "$GRUBCFG"
 
        # Ensure rootwait and rw exist
        sed -i '/^[[:space:]]*linux /{
            /rootwait/!s|$| rootwait|
            / rw/!s|$| rw|
        }' "$GRUBCFG"
 
        # Add Radeon + HDMI kernel parameters if missing
        sed -i '/^[[:space:]]*linux /{
            /radeon.dpm=0/!s|$| radeon.dpm=0|
            /video=HDMI-A-1:/!s|$| video=HDMI-A-1:1920x1080@60|
        }' "$GRUBCFG"
 
        # Add initrd line ONLY if missing
        sed -i '/^[[:space:]]*linux /{
            n
            /^[[:space:]]*initrd /!a\    initrd /initrd
        }' "$GRUBCFG"
 
    else
        bbwarn "grub.cfg not found at ${GRUBCFG}"
    fi
}
