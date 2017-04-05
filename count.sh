#!/bin/bash
#Program:
#       统计目录：自定义
#     请选择统计文件类型
#     1）文件
#     2）目录
#     3）块设备
#     4）字符设备
#History:
#2017-3-1            Song             Release: 1.0
read -p "Input a dirctory name which you want to count:" DIR
cd $DIR
 
file()
{
filenum=0
for i in `ls`
do
 if [ -f $i ]
   then
      let filenum=filenum+1
 fi
done
echo filenum=$filenum
}
 
directory()
{
dirnum=0
for i in `ls`
do
  if [ -d $i ]
   then
    let dirnum=dirnum+1
  fi
done
echo "dirnum=$dirnum"
}
 
block()
{
blocknum=0
for i in `ls`
do
  if [ -b $i ]
   then
    let blocknum=blocknum+1
  fi
done
echo "blocknum=$blocknum"
}
 
character()
{
cnum=0
for i in `ls`
do
  if [ -c $i ]
   then
    let cnum=cnum+1
  fi
done
echo "cnum=$cnum"
}

PS3="choose a label:"
select kind in file directory block character
do
 $kind
 break
done
