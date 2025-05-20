make(){
 mkdir -p asm
# Make exec that removes all comments
 ./vectal <rcom.vc >asm/rcom.a
 nasm asm/rcom.a -o rcom
 chmod +x ./rcom
# Convert all basic code headers to asm
 for i in $(fLSx vhdrs vh)
 do
  j=$(echo $i|sed "s/\.vh/\.ah/")
  <vhdrs/$i ./rcom|./vectal >hdrs/$j
 done
# Make new vectal binary for functionality testing
 <vectal.vc ./vectal >asm/testvectal.a
 <dvectal.vc ./vectal >asm/testdvectal.a
 nasm asm/testvectal.a -o testvectal 
 nasm asm/testdvectal.a -o testdvectal 
 chmod +x ./testvectal
 chmod +x ./testdvectal
}
install(){
 sudo cp ./vectal /usr/bin/
 sudo cp ./rcom /usr/bin/
}
test(){
 <test.vc ./rcom |./testvectal >test.a
 nasm test.a -o test
}
#Backup everything to another file, uses root privleges because could be to a mounted floppy.
backup(){
 sudo rm -rf $1/vectal
 sudo mkdir $1/vectal
 sudo cp ./*.a $1/vectal
 sudo cp ./*.vc $1/vectal
 sudo cp ./*.sh $1/vectal
 sudo mkdir $1/vectal/choices
 sudo mkdir $1/vectal/hdrs
 sudo cp ./choices/*.ah $1/vectal/choices/
 sudo cp ./hdrs/*.ah $1/vectal/hdrs/
}
# Back propagate changes of the derived executable sourcewdown to the backup 
#  executable source.
backprop(){
 cp ./asm/testvectal.a ./vectal.a
 nasm vectal.a -o vectal
 chmod +x ./vectal
}
init(){
# Bootstrap vectal version that's in pure nasm assembly.
 nasm vectal.a -o vectal
 chmod +x ./vectal
}
wc ./vectal 2>/dev/null 1>/dev/null
if [[ $? > 0 ]]
then
 init
fi
make
$1 $2
