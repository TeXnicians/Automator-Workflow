# !/bin/sh
path="$HOME/Google Drive/UIUC Files/2nd Semester/CEE 515/HWs"
cd "$path"
for filename in `find . -type d -name 'hw*'`
do
    temp1=${filename%_*}
    temp2=${temp1#./hw}
    echo $temp2
done
newnum=`expr $temp2 + 1`
newnumf=$newnum
if [ "${#newnum}" -eq 1 ] ; then
  newnumf=0${newnum}
fi
oldnum=${temp2/#0/}
mkdir ./hw${newnumf}
mkdir ./hw${newnumf}/codes
mkdir ./hw${newnumf}/figures
for file in `find -E $filename -regex '.*\.(tex|bib|sty)$'`
do
    #echo $file
    newfile=${file//$temp2/$newnumf}
    echo creating $newfile
    cp $file $newfile
    
    if [ ${newfile##*.} = "tex" ] ; then
	echo modifying ${newfile##*\/}
	sed -i "" -e "s/\\\\def\\\\hwnum{$oldnum}/\\\\def\\\\hwnum{$newnum}/g" "$newfile"
	sed -i "" -e '/\begin{numsol}/,/\end{numsol}/d' "$newfile"
    fi
done
