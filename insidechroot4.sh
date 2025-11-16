
export LFS=""
cd /sources

./chap8_end.sh # Cleaning chapter 8 residue


cat > /etc/systemd/network/10-ether0.link << "EOF"
[Match]
# Change the MAC address as appropriate for your network device
MACAddress=14:ab:c5:44:5b:1a
[Link]
Name=ether0
EOF

cat > /etc/systemd/network/10-eth-dhcp.network << "EOF"
[Match]
Name=ether0
[Network]
DHCP=ipv4
[DHCPv4]
UseDomains=false
EOF

cat > /etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf
# domain <Your Domain Name>
nameserver 8.8.8.8
nameserver 8.8.4.4
# End /etc/resolv.conf
EOF

echo "batman" > /etc/hostname

cat > /etc/hosts << "EOF"
# Begin /etc/hosts
127.0.0.1 localhost
::1 ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
# End /etc/hosts
EOF


echo "configuring system  clock...."
sleep 2
cat > /etc/adjtime << "EOF"
0.0 0 0.0
0
LOCAL
EOF


echo "configuring linux console...."
sleep 2
cat > /etc/vconsole.conf << "EOF"
KEYMAP=us
FONT=Lat2-Terminus16
EOF

LC_ALL=en_IN.utf8 locale charmap
LC_ALL=en_IN.utf8 locale language
LC_ALL=en_IN.utf8 locale charmap
LC_ALL=en_IN.utf8 locale int_curr_symbol
LC_ALL=en_IN.utf8 locale int_prefix


echo "configuring system locale...."
sleep 2
cat > /etc/locale.conf << "EOF"
LANG=en_IN.utf8
EOF

cat > /etc/profile << "EOF"
# Begin /etc/profile
for i in $(locale); do
    unset ${i%=*}
done
if [[ "$TERM" = linux ]]; then
    export LANG=C.UTF-8
else
    source /etc/locale.conf
    for i in $(locale); do
        key=${i%=*}
        if [[ -v $key ]]; then
            export $key
        fi
    done
fi
# End /etc/profile
EOF


echo "creating inputrc..."
sleep 2
cat > /etc/inputrc << "EOF"
# Begin /etc/inputrc
# Modified by Chris Lynn <roryo@roryo.dynup.net>

# Allow the command prompt to wrap to the next line
set horizontal-scroll-mode Off

# Enable 8-bit input
set meta-flag On
set input-meta On

# Turns off 8th bit stripping
set convert-meta Off

# Keep the 8th bit for display
set output-meta On

# none, visible or audible
set bell-style none

# All of the following map the escape sequence of the value
# contained in the 1st argument to the readline specific functions
"\eOd": backward-word
"\eOc": forward-word

# for linux console
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert

# for xterm
"\eOH": beginning-of-line
"\eOF": end-of-line

# for Konsole
"\e[H": beginning-of-line
"\e[F": end-of-line

# End /etc/inputrc
EOF

echo "creating shells file..."
sleep 2
cat > /etc/shells << "EOF"
# Begin /etc/shells
/bin/sh
/bin/bash
# End /etc/shells
EOF
echo "shell file created...."
sleep 3

echo "configuring chapter9 last part....."
sleep 2

mkdir -pv /etc/systemd/system/getty@tty1.service.d
cat > /etc/systemd/system/getty@tty1.service.d/noclear.conf << EOF
[Service]
TTYVTDisallocate=no
EOF

rm -rf /etc/systemd/system/foobar.service.d

mkdir -pv /etc/systemd/coredump.conf.d
cat > /etc/systemd/coredump.conf.d/maxuse.conf << EOF
[Coredump]
MaxUse=1G
EOF


echo "Done till chapter 9...."
sleep 2
