
make mrproper

if [ -f /boot/config-$VERSION ]; then
    cp -v /boot/config-$VERSION .config
fi

make defconfig


sed -i \
-e '/CONFIG_FB_VESA/d' \
-e '/CONFIG_FB_EFI/d' \
-e '/CONFIG_FB_SIMPLE/d' \
-e '/CONFIG_FRAMEBUFFER_CONSOLE/d' \
-e '/CONFIG_FB/d' \
-e '$aCONFIG_FB=y' \
-e '$aCONFIG_FB_VESA=y' \
-e '$aCONFIG_FB_SIMPLE=y' \
-e '$a# CONFIG_FB_EFI is not set' \
-e '$aCONFIG_FRAMEBUFFER_CONSOLE=y' \
.config

make -j$(nproc)
make modules_install

cp -iv arch/x86/boot/bzImage /boot/vmlinuz-$VERSION-lfs-12.3-systemd

cp -iv System.map /boot/System.map-$VERSION

cp -iv .config /boot/config-$VERSION

cp -r Documentation -T /usr/share/doc/linux-$VERSION

install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf
install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true
# End /etc/modprobe.d/usb.conf
EOF
