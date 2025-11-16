
echo "cleaning chapter7 residue...."
rm -rf /usr/share/{info,man,doc}/*
find /usr/{lib,libexec} -name \*.la -delete
rm -rf /tools
echo "deleted"
sleep 3
