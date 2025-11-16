
export LFS=""

cd /sources

# CHAPTER 7
for package in gettext bison perl python texinfo util-linux; do
	source packageinstall.sh 7 $package
done

cd ..
echo "Done Compiling Chapter 7....."
