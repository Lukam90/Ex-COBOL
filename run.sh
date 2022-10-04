module="GetSum"

#cobc -m $module.cbl
cobc -x -o test.exe $1
./test.exe

mv *.exe temp/

sh _copy.sh