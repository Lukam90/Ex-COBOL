module="videos/GetSum.cbl"

#cobc -m $module
cobc -x -o test.exe $1
./test.exe

sh _copy.sh