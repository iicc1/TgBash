if [ "$(user_is_admin)" ] || [ "$(user_is_owner)" == true ] || [ `db_hget "${AHASH}" "${USER[ID]}"` ]; then

	echo $MESSAGE | grep -w "^/setwelcome"
		if [ $? == 0 ]; then
			db_set "${WHASH}" "${ENTRY[1-]}"
			send_markdown_message "${CHAT[ID]}" "*New welcome*
${ENTRY[1-]}"
		fi

	echo $MESSAGE | grep -w "^/setlang"
		if [ $? == 0 ]; then
			db_set "${LHASH}" "${ENTRY[1-]}"
			send_markdown_message "${CHAT[ID]}" "*New lang*
${ENTRY[1-]}"
		fi

	echo $MESSAGE | grep -w "^/rmlang"
		if [ $? == 0 ]; then
			db_del "${LHASH}"
			send_markdown_message "${CHAT[ID]}" "*Lang disabled*, using global lang: ${GLOBAL_LANG}"
		fi

case $MESSAGE in
	'/kick')
		kick_chat_member "${CHAT[ID]}" "${REPLY[ID]}"
		unban_chat_member "${CHAT[ID}" "${REPLY[ID]}"
	;;

	'/ban')
		kick_chat_member "${CHAT[ID]}" "${REPLY[ID]}"
	;;

	'/unban')
		unban_chat_member "${CHAT[ID]}" "${REPLY[ID]}"
	;;

	'/newadmin')
	if [[ `user_is_admin` == creator ]] || [[ `user_is_owner` == true ]]; then
		if [[ ${REPLY[USERNAME]} ]]; then user="@"${REPLY[USERNAME]}; else user=${REPLY[FIRST_NAME]}; fi
		db_hset "${AHASH}" "${REPLY[ID]}" "${user}"
		send_markdown_message "${CHAT[ID]}" "*New admin* ${REPLY[FIRST_NAME]} (${REPLY[ID]})"
	fi
	;;

	'/deladmin')
	if [[ `user_is_admin` == creator ]] || [[ `user_is_owner` == true ]]; then
		db_hdel "${AHASH}" "${REPLY[ID]}"
		send_markdown_message "${CHAT[ID]}" "*Admin deleted* ${REPLY[FIRST_NAME]} (${REPLY[ID]})"
	fi
	;;

	'/test')
		send_markdown_message "${CHAT[ID]}" "OK. You are *admin*" "$reply"
	;;

esac
fi
