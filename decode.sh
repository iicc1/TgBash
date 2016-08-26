declare -a color
declare -a like_hand
declare -a dislike_hand
declare -a applause_hand
declare -a perfect_hand
declare -a surprise_hand
declare -a bye_hand

keymoji="\\\ud83d"

color[0]="\\\ud83c"
color[1]=${color[0]}"\\\udffb"
color[2]=${color[0]}"\\\udffc"
color[3]=${color[0]}"\\\udffd"
color[4]=${color[0]}"\\\udffe"
color[5]=${color[0]}"\\\udfff"

like_hand[1]="\\\udc4d"
like_hand[2]="\\\udc4d"${color[1]}
like_hand[3]="\\\udc4d"${color[2]}
like_hand[4]="\\\udc4d"${color[3]}
like_hand[5]="\\\udc4d"${color[4]}
like_hand[6]="\\\udc4d"${color[5]}

dislike_hand[1]="\\\udc4e"
dislike_hand[2]="\\\udc4e"${color[1]}
dislike_hand[3]="\\\udc4e"${color[2]}
dislike_hand[4]="\\\udc4e"${color[3]}
dislike_hand[5]="\\\udc4e"${color[4]}
dislike_hand[6]="\\\udc4e"${color[5]}

perfect_hand[1]="\\\udc4c"
perfect_hand[2]="\\\udc4c"${color[1]}
perfect_hand[3]="\\\udc4c"${color[2]}
perfect_hand[4]="\\\udc4c"${color[3]}
perfect_hand[5]="\\\udc4c"${color[4]}
perfect_hand[6]="\\\udc4c"${color[5]}

fist_hand[1]="\\\udc4a"
fist_hand[2]="\\\udc4a"${color[1]}
fist_hand[3]="\\\udc4a"${color[2]}
fist_hand[4]="\\\udc4a"${color[3]}
fist_hand[5]="\\\udc4a"${color[4]}
fist_hand[6]="\\\udc4a"${color[5]}

surprise_hand[1]="\\\ude4c"
surprise_hand[2]="\\\ude4c"${color[1]}
surprise_hand[3]="\\\ude4c"${color[2]}
surprise_hand[4]="\\\ude4c"${color[3]}
surprise_hand[5]="\\\ude4c"${color[4]}
surprise_hand[6]="\\\ude4c"${color[5]}

applause_hand[1]="\\\udc4f"
applause_hand[2]="\\\udc4f"${color[1]}
applause_hand[3]="\\\udc4f"${color[2]}
applause_hand[4]="\\\udc4f"${color[3]}
applause_hand[5]="\\\udc4f"${color[4]}
applause_hand[6]="\\\udc4f"${color[5]}

bye_hand[1]="\\\udc4b"
bye_hand[2]="\\\udc4b"${color[1]}
bye_hand[3]="\\\udc4b"${color[2]}
bye_hand[4]="\\\udc4b"${color[3]}
bye_hand[5]="\\\udc4b"${color[4]}
bye_hand[6]="\\\udc4b"${color[5]}

decode() {
perl -p -e "s[$keymoji\\\ude15][😕]g"|
perl -p -e "s[$keymoji\\\ude0c][😌]g"|
perl -p -e "s[$keymoji\\\ude4a][🙊]g"|
perl -p -e "s[$keymoji\\\udc4c\\\ud83c\\\udffb][👌🏻]g"|
perl -p -e "s[$keymoji\\\ude05][😅]g"|
perl -p -e "s[$keymoji\\\ude01][😁]g"|

perl -p -e "s[$keymoji${like_hand[6]}][👍🏿]g"|
perl -p -e "s[$keymoji${like_hand[5]}][👍🏾]g"|
perl -p -e "s[$keymoji${like_hand[4]}][👍🏽]g"|
perl -p -e "s[$keymoji${like_hand[3]}][👍🏼]g"|
perl -p -e "s[$keymoji${like_hand[2]}][👍🏻]g"|
perl -p -e "s[$keymoji${like_hand[1]}][👍]g"|

perl -p -e "s[$keymoji${dislike_hand[6]}][👎🏿]g"|
perl -p -e "s[$keymoji${dislike_hand[5]}][👎🏾]g"|
perl -p -e "s[$keymoji${dislike_hand[4]}][👎🏽]g"|
perl -p -e "s[$keymoji${dislike_hand[3]}][👎🏼]g"|
perl -p -e "s[$keymoji${dislike_hand[2]}][👎🏻]g"|
perl -p -e "s[$keymoji${dislike_hand[1]}][👎]g"|

perl -p -e "s[$keymoji${fist_hand[6]}][👊🏿]g"|
perl -p -e "s[$keymoji${fist_hand[5]}][👊🏾]g"|
perl -p -e "s[$keymoji${fist_hand[4]}][👊🏽]g"|
perl -p -e "s[$keymoji${fist_hand[3]}][👊🏼]g"|
perl -p -e "s[$keymoji${fist_hand[2]}][👊🏻]g"|
perl -p -e "s[$keymoji${fist_hand[1]}][👊]g"|

perl -p -e "s[$keymoji${perfect_hand[6]}][👌🏿]g"|
perl -p -e "s[$keymoji${perfect_hand[5]}][👌🏾]g"|
perl -p -e "s[$keymoji${perfect_hand[4]}][👌🏽]g"|
perl -p -e "s[$keymoji${perfect_hand[3]}][👌🏼]g"|
perl -p -e "s[$keymoji${perfect_hand[2]}][👌🏻]g"|
perl -p -e "s[$keymoji${perfect_hand[1]}][👌]g"|

perl -p -e "s[$keymoji${surprise_hand[6]}][🙌🏿]g"|
perl -p -e "s[$keymoji${surprise_hand[5]}][🙌🏾]g"|
perl -p -e "s[$keymoji${surprise_hand[4]}][🙌🏽]g"|
perl -p -e "s[$keymoji${surprise_hand[3]}][🙌🏼]g"|
perl -p -e "s[$keymoji${surprise_hand[2]}][🙌🏻]g"|
perl -p -e "s[$keymoji${surprise_hand[1]}][🙌]g"|

perl -p -e "s[$keymoji${applause_hand[6]}][👏🏿]g"|
perl -p -e "s[$keymoji${applause_hand[5]}][👏🏾]g"|
perl -p -e "s[$keymoji${applause_hand[4]}][👏🏽]g"|
perl -p -e "s[$keymoji${applause_hand[3]}][👏🏼]g"|
perl -p -e "s[$keymoji${applause_hand[2]}][👏🏻]g"|
perl -p -e "s[$keymoji${applause_hand[1]}][👏]g"|

perl -p -e "s[$keymoji${bye_hand[6]}][👋🏿]g"|
perl -p -e "s[$keymoji${bye_hand[5]}][👋🏾]g"|
perl -p -e "s[$keymoji${bye_hand[4]}][👋🏽]g"|
perl -p -e "s[$keymoji${bye_hand[3]}][👋🏼]g"|
perl -p -e "s[$keymoji${bye_hand[2]}][👋🏻]g"|
perl -p -e "s[$keymoji${bye_hand[1]}][👋]g"

}

if [ "$1" = "-d" ]; then
decode
fi

if [ "$1" = "-r" ]; then
read=$(read dec | decode)
echo $read
fi