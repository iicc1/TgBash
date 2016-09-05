<<-/
This commands will be available to all users.
You can add a command with 'echo $MESSAGE | grep -w "/echo"' to do the entries compatibles.
/

echo $MESSAGE | grep -w "/echo"
	if [ $? == 0 ]; then
		send_markdown_message "${CHAT[ID]}" "${ENTRY[1-]}"
	fi
	
echo $MESSAGE | grep -w "/rev"
        if [ $? == 0 ]; then
		change=$(echo ${ENTRY[1-]} | rev)
		send_markdown_message "${CHAT[ID]}" "$change"
	fi
	

echo $MESSAGE | grep -w "/ct"
	if [ $? == 0 ]; then
		if [ ${CHAT[TYPE]} == private ]; then
			MESSAGE=$(echo $MESSAGE | cut -d " " -f2-)
			forward "${ADMINS}" "${CHAT[ID]}" "${MESSAGE[ID]}"
			send_markdown_message "${CHAT[ID]}" "${lang[MD]}"
		else
			exit
		fi
    	fi
	
echo $MESSAGE | grep -w "/calc"
	if [ $? == 0 ]; then
		MESSAGE=$(echo ${ENTRY[1-]} | sed 's/\+/%2B/g' | sed 's/(/%28/g' | sed 's/)/%29/g')
	 	EXPR=$(curl -s http://api.mathjs.org/v1/?expr=$MESSAGE)
		send_markdown_message "${CHAT[ID]}" "*${EXPR}*" "$reply"
	fi

echo $MESSAGE | grep -w "/res"
	if [ $? == 0 ]; then
		USR=$(echo $MESSAGE | cut -d " " -f2)
		getchat "$USR"
		id=$(echo $res | jq -r '.result .id')
		type=$(echo $res | jq -r '.result .type')
		title=$(echo $res | jq -r '.result .title')
		username=$(echo $res | jq -r '.result .username')
		first_name=$(echo $res | jq -r '.result .first_name')
		last_name=$(echo $res | jq -r '.result .last_name')
		send_markdown_message "${CHAT[ID]}" "@$username ($id)
*Firstname* _ $first_name _
*Lastname* _ $last_name _
*Title* _ $title _
*Type* _ $type _"
		exit
	fi


case $MESSAGE in
	'/start' | '/help')
		if [ ${CHAT[TYPE]} == private ]; then
			send_action "${CHAT[ID]}" "typing"
			send_markdown_message "${CHAT[ID]}" "${lang[START]}"
		fi
	;;
			
	'/calculator')
		startproc "./calculator"
	;;
		
	'/getinfo')
		send_markdown_message "${CHAT[ID]}" "*${lang[USER]}* @${REPLY[USERNAME]}
*${lang[ID]}* ${REPLY[ID]}" "$reply"
	;;
			
	'/info')
		send_inline_keyboard "${CHAT[ID]}" "${lang[INFO]}" "${inline_keyboard[help]}" "$reply"
	;;
     			
     	'/kickme')
     		kick_chat_member "${CHAT[ID]}" "${USER[ID]}"
     		unban_chat_member "${CHAT[ID]}" "${USER[ID]}"
     	;;
     			
     	'/myinfo')
		send_markdown_message "${CHAT[ID]}" "*${lang[ID]}* ${USER[ID]}
*${lang[USER]}* @${USER[USERNAME]}
*${lang[NAME]}* ${USER[FIRST_NAME]}
*${lang[LASTNAME]}* ${USER[LAST_NAME]}"
	;;
			
	'/getmembers')
		getmembers "${CHAT[ID]}" "${lang[GETMEMBERS]}
"
	;;

	'/cancel')
		if tmux ls | grep -q $copname; then killproc && send_markdown_message "${CHAT[ID]}" "*Command canceled*.";else send_markdown_message "${CHAT[ID]}" "*No command is currently running*.";fi
	;;
			
			
	*)
		if tmux ls | grep -v send | grep -q $copname;then inproc; else send_message "${CHAT[ID]}" "" "safe";fi
	;;
esac