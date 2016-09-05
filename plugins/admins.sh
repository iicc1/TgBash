if [ "$(user_is_admin)" == true ] || [ $ADMIN == 1 ]; then

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

	'/test')
		send_markdown_message "${CHAT[ID]}" "OK. You are *admin*" "$reply"
	;;

esac
fi