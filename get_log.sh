#!/usr/bin/bash
LogPath="***************"
OutPath="***************"
GrepWord="*******************"
echo -n "Start_DATE(YYYYMMDD)":
#入力を受付、その入力を「str」に代入
read LogStart 
echo -n "End_DATE(YYYYMMDD)":
read LogEnd
StartYear=$(echo $LogStart | cut -c 1-4)
StartMonth=$(echo $LogStart | cut -c 5-6)
StartDay=$(echo $LogStart | cut -c 7-8)
EndYear=$(echo $LogEnd | cut -c 1-4)
EndMonth=$(echo $LogEnd | cut -c 5-6)
EndDay=$(echo $LogEnd | cut -c 7-8)
echo $StartYear
echo $StartMonth
echo $StartDay
echo $EndYear
echo $EndMonth
echo $EndDay
if [ $StartYear -eq $EndYear ]; then
    #年一致
    if [ $StartMonth -eq $EndMonth ]; then
        #月一致
        for aaa in `seq -f %02g ${StartDay} ${Endday}` ;
            do grep ${aaa}  ${LogPath}/access_log.${StartYear}-${StartMonth}-${aaa} >> ${OutPath}/${StartYear}${StartMonth}${StartDay}-${EndYear}${EndMonth}${EndDay}504.log ;
        done

    else
        #月不一致
        #先月の最終日取得
        MonthLastDay=$(date +"%Y%m%d" -d"`date +"%Y${StartMonth}01"` 1 days ago + 1 month")
        for aaa in `seq -f %02g ${StartDay} ${MonthLastDay}` ;
            do grep -A 2 $GrepWord ${LogPath}/access_log.${StartYear}-${StartMonth}-${aaa} >> ${OutPath}/${StartYear}${StartMonth}${StartDay}-${EndYear}${EndMonth}${EndDay}504.log ;
        done
        for bbb in `seq -f %02g 01 ${EndDay}` ;
            do grep -A 2 $GrepWord ${LogPath}/access_log.${StartYear}-${EndMonth}-${bbb} >> ${OutPath}/${StartYear}${StartMonth}${StartDay}-${EndYear}${EndMonth}${EndDay}504.log ;
        done
    fi

else
    #年不一致
    YearLastDay=$(date +"%Y%m%d" -d"`date +"%Y${StartMonth}01"` 1 days ago + 1 month")
    for aaa in `seq -f %02g ${StartDay} ${MonthLastDay}` ;
        do grep -A 2 $GrepWord ${LogPath}/access_log.${StartYear}-${StartMonth}-${aaa} >> ${OutPath}/${StartYear}${StartMonth}${StartDay}-${EndYear}${EndMonth}${EndDay}504.log ;
    done
    for bbb in `seq -f %02g 01 ${EndDay}` ;
        do grep -A 2 $GrepWord ${LogPath}/access_log.${EndYear}-${EndMonth}-${bbb} >> ${OutPath}/${StartYear}${StartMonth}${StartDay}-${EndYear}${EndMonth}${EndDay}504.log ;
    done

fi
