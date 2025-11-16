
export LFS=""
cd /sources

./chap7_end.sh # cleaning chapter 7 residue

# CHAPTER 8
for package in man-pages iana-etc glibc zlib bzip2 xz lz4 zstd file readline m4 bc flex tcl expect dejagnu pkgconf binutils gmp mpfr mpc attr acl libcap libxcrypt shadow; do
	source packageinstall.sh 8 $package
done


for package in gcc ncurses sed psmisc gettext bison grep bash libtool gdbm gperf expat inetutils less perl xml::parser intltool autoconf automake openssl elfutils libffi python flit-core wheel setuptools ninja meson kmod coreutils check diffutils gawk findutils groff grub gzip iproute2 kbd libpipeline make patch tar texinfo vim markupsafe jinja2 systemd dbus procps util-linux e2fsprogs; do
	source packageinstall.sh 8 $package
done

cd ..
echo "Done Compiling Chapter 8........."
