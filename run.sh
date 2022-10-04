module="GetSum"
name="prefill"

#cobc -m $module.cbl
cobc -x -o $name.exe $name.cbl
./$name.exe

mv *.exe temp/

sh _copy.sh