if [ "$(user_is_owner)" ]; then
source langs.sh

echo $MESSAGE | grep -w "^/broadcast"
	if [ $? == 0 ]; then
		send_markdown_message "${USER[ID]}" "${lang[BC]}
_${ENTRY[1-]}_" "$reply"
		shift
		for f in $(cat count);do send_markdown_message ${f//COUNT} "${ENTRY[1-]}"; $sleep;done
	fi

    	
echo $MESSAGE | grep -w "^/su"
	if [ $? == 0 ]; then
		COMMAND=$(${ENTRY[1-]})
		send_markdown_message "${CHAT[ID]}" "*${COMMAND}*"
	fi
	
echo $MESSAGE | grep -w "^/reply"
	if [ $? == 0 ]; then
		send_message "${REPLY[FW_ID]}" "${ENTRY[1-]}"
		echo "OK"
	fi

echo $MESSAGE | grep -w "^!edit"
	if [ $? == 0 ]; then
		edit_message "${CHAT[ID]}" "${ENTRY[1-]}"
	fi

echo $MESSAGE | grep -w "^/setwelcome"
	if [ $? == 0 ]; then
		db_set welcome "${ENTRY[1-]}"
		send_markdown_message "${CHAT[ID]}" "*New welcome*
${ENTRY[1-]}"
	fi


echo $MESSAGE | grep -w "^/delwelcome"
	if [ $? == 0 ]; then
		db_del welcome
		send_markdown_message "${CHAT[ID]}" "Welcome deleted"
	fi


    	
echo $MESSAGE | grep -w "^/lang"
	if [ $? == 0 ]; then
		setlang=$(set_lang)
		if [ "$setlang" == true ]; then
			setlng=$(echo ${ENTRY[1]} | tr [:upper:] [:lower:])
			sed -i '4 s/'$Language'/'${setlng}'/g' config.sh
			send_markdown_message "${CHAT[ID]}" "${lang[LANG]} *${setlng}*" "$reply"
		else
			send_markdown_message "${CHAT[ID]}" "${lang[LANG_NO_AVAILABLE]}" "$reply"
		fi
	fi


    	
case $MESSAGE in
	'/leavechat')
		send_markdown_message "${USER[ID]}" "${lang[LEAVECHAT]}"
		leave_chat "${CHAT[ID]}"
	;;

	'/newadmin')
		echo "${REPLY[ID]}," >> data/admins
		send_markdown_message "${CHAT[ID]}" "${lang[ID]} ${REPLY[ID]} ${lang[NEWADMIN]}" "$reply"
	;;
			
	'/gban')
		perl -pi -e "s[GBANS=\(][GBANS=\(\n\t${REPLY[ID]}]g" data/gbans.sh
		send_markdown_message "${CHAT[ID]}" "${lang[ID]} ${REPLY[ID]} *${lang[GBANNED]}.*"
		kick_chat_member "${CHAT[ID]}" "${REPLY[ID]}"
	;;

	'/reload')
		exit && exec bash bot.sh tmux
	;;

	'/ungban')
		sed -i "/${REPLY[ID]}/d" data/gbans.sh
		send_markdown_message "${CHAT[ID]}" "ID: ${REPLY[ID]} *${lang[UNGBANNED]}*."
		unban_chat_member "${CHAT[ID]}" "${REPLY[ID]}"
	;;
			
	'/infobot')
		send_markdown_message "${CHAT[ID]}" "*${lang[NAME]}* ${BOT[NAME]}
*${lang[USER]}* @${BOT[USERNAME]}
*${lang[ID]}* ${BOT[ID]}" "$reply"
	;;
		
	'/sudos')
		send_markdown_message "${CHAT[ID]}" "${lang[SUDOS]}
${ADMINS}"
	;;
		
	'/ip')	
		IP=$(curl -s http://api.ipify.org)
		send_markdown_message "${CHAT[ID]}" "${lang[IP]} *$IP*"
	;;

esac
fi
