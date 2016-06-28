#!/bin/bash
#*.*encoding=utf-8*.*

# Edit your commands in this file.
if [ "$1" = "source" ];then
	FILE_REGEX='/'
else
# Return chats and gbans in console
send_register
# Load langs
source lang.sh
# Load inline keyboards
source settings/inline_keyboards.sh

	if ! tmux ls | grep -v send | grep -q $copname; then
		[ ! -z ${URLS[*]} ] && {
		curl -s ${URLS[*]} -o $NAME
			send_file "${CHAT[ID]}" "$NAME" "$CAPTION"
			rm "$NAME"
		}
		[ ! -z ${LOCATION[*]} ] && send_location "${CHAT[ID]}" "${LOCATION[LATITUDE]}" "${LOCATION[LONGITUDE]}"

		# Inline
		if [ $INLINE == 1 ]; then
			# Inline examples
			if [[ ${iQUERY[MSG]} == photo ]]; then
				answer_inline_query "${iQUERY[ID]}" "photo" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg"
			fi

			if [[ ${iQUERY[MSG]} == sticker ]]; then
				answer_inline_query "${iQUERY[ID]}" "cached_sticker" "BQADBAAD_QEAAiSFLwABWSYyiuj-g4AC"
			fi

			if [[ ${iQUERY[MSG]} == gif ]]; then
				answer_inline_query "${iQUERY[ID]}" "gif" "http://www.compciv.org/files/images/cli/cli-bash-script-hello-world.gif" "http://www.compciv.org/files/images/cli/cli-bash-script-hello-world.gif"
			fi
			if [[ ${iQUERY[MSG]} == github ]]; then
				answer_inline_query "${iQUERY[ID]}" "article" "GitHub" "This is a bot bash. Get code [here](https://github.com/iicc1/TgBash)" "By @iicc1 and @Jarriz" "https://assets-cdn.github.com/images/modules/logos_page/GitHub-Mark.png"
			fi
		fi
	fi

  	# Services
  	  # If is new member then
	if [ $NEW_MEMBER ]; then
		send_markdown_message "${CHAT[ID]}" "Welcome @${NEW_MEMBER[USERNAME]} to *${CHAT[TITLE]}*"
	fi
	
	  # If is kicked then
	if [ $OUT_MEMBER ]; then
		send_markdown_message "${CHAT[ID]}" "Bye @${OUT_MEMBER[USERNAME]}, I see you later..."
	fi
	
	  # If is a forward from private (user) then
	if [ $FORWARD ]; then
	  if [ ${CHAT[TYPE]} == private ]; then
		send_markdown_message "${CHAT[ID]}" "*ID* ${FORWARD[ID]}" "$reply"
	  fi
	  if [ ${CHAT[TYPE]} != private ]; then
		exit
	  fi
	fi
	
	 # If is a forward from chat (channel) then
	if [ $FORWARD_CHAT ]; then
	  if [ ${CHAT[TYPE]} == private ]; then
		send_markdown_message "${CHAT[ID]}" "*Channel ID* ${FORWARD_CHAT[ID]}" "$reply"
	  fi
	  if [ ${CHAT[TYPE]} != private ]; then
		exit
	  fi
	fi
	
	  # If is gbanned then
	if [ $GBAN == 1 ]; then
		kick_chat_member "${CHAT[ID]}" "${GBAN}"
		kick_chat_member "${CHAT[ID]}" "${NEW_MEMBER[ID]}"
		exit 
	fi
	
	# User commands
    	echo $MESSAGE | grep "^/echo"
        if [ $? == 0 ]; then
	MESSAGE=$(echo $MESSAGE | cut -d " " -f2- | sed 's/\/echo//g')
	  if [ "$MESSAGE" ]; then
		send_markdown_message "${CHAT[ID]}" "$MESSAGE"
	  fi
	  if [ ! "$MESSAGE" ]; then
		send_markdown_message "${CHAT[ID]}" "*ERROR*. Write something then."
	  fi
	fi
	
	echo $MESSAGE | grep "^/ct"
        if [ $? == 0 ]; then
         if [ ${CHAT[TYPE]} == private ]; then
	  MESSAGE=$(echo $MESSAGE | cut -d " " -f2-)
	  forward "${ADMINS}" "${CHAT[ID]}" "${MESSAGE[ID]}"
	  send_markdown_message "${CHAT[ID]}" "*Message delivered*."
	 fi
	 if [ ${CHAT[TYPE]} != private ]; then
	  exit
	 fi
    	fi
	
	echo $MESSAGE | grep "^/calc"
        if [ $? == 0 ]; then
	 MESSAGE=$(echo $MESSAGE | cut -d " " -f2 | sed 's/\+/%2B/g' | sed 's/(/%28/g' | sed 's/)/%29/g')
	 EXPR=$(curl -s http://api.mathjs.org/v1/?expr=$MESSAGE)
		send_markdown_message "${CHAT[ID]}" "*${EXPR}*" "$reply"
    	fi
    	
    	echo $MESSAGE | grep "^/res @"
	if [ $? == 0 ]; then
		USR=$(echo $MESSAGE | cut -d "@" -f2)
		getchat "@$USR"
		res=$(echo $res | cut -d '"' -f7 | tr -d ":" | tr -d ",")
		send_markdown_message "${CHAT[ID]}" "$res"
		exit
	fi

	case $MESSAGE in
		'/start' | '/help')
		if [ ${CHAT[TYPE]} == private ]; then
			send_action "${CHAT[ID]}" "typing"
			send_markdown_message "${CHAT[ID]}" "${lang[START]}"
		
		fi
		
		if [ ${CHAT[TYPE]} != private ]; then
			send_markdown_message "${CHAT[ID]}" "${lang[PRIVATE]}"
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
			send_inline_keyboard "${CHAT[ID]}" "This is a bashbot of *Telegram* written entirely in *bash*.
More info [here](https://github.com/iicc1/TgBash)" "${inline_keyboard[help]}" "$reply"
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
			send_markdown_message "${CHAT[ID]}" "*Members here*:
${MEMBERS[COUNT]}"
			;;

		'/cancel')
			if tmux ls | grep -q $copname; then killproc && send_markdown_message "${CHAT[ID]}" "*Command canceled*.";else send_markdown_message "${CHAT[ID]}" "*No command is currently running*.";fi
			;;
			
		*)
			if tmux ls | grep -v send | grep -q $copname;then inproc; else send_message "${CHAT[ID]}" "" "safe";fi
			;;
	esac
	
	
	# Admin commands
	if [ $ADMIN == 1 ]; then
	  echo $MESSAGE | grep "^/broadcast"
        	if [ $? == 0 ]; then
	 		MESSAGE=$(echo $MESSAGE | cut -d " " -f2-)
			send_markdown_message "${CHAT[ID]}" "*Broadcast delivered*" "$reply"
  	 	shift
			for f in $(cat count);do send_markdown_message ${f//COUNT} "$MESSAGE"; $sleep;done
    		fi
    	
    	  echo $MESSAGE | grep "^/su"
        	if [ $? == 0 ]; then
	 		MESSAGE=$(echo $MESSAGE | cut -d " " -f2-)
	 		COMMAND=$($MESSAGE)
			send_markdown_message "${CHAT[ID]}" "*${COMMAND}*"
    		fi
    	
    	echo $MESSAGE | grep "^/lang"
	        MESSAGE=$(echo $MESSAGE | cut -d " " -f2-)
	 	if [ $MESSAGE == EN ] || [ $MESSAGE == ES ]; then
		  if [ $? == 0 ]; then
			sed -i '6 s/'$LANG'/'$MESSAGE'/g' lang.sh
			send_markdown_message "${CHAT[ID]}" "${lang[LANG]} *$MESSAGE*" "$reply"
		  fi
    		fi

    	
	case $MESSAGE in
	 	'/leavechat')
			send_markdown_message "${CHAT[ID]}" "*CHAT LEAVED*"
   			leave_chat "${CHAT[ID]}"
     			;;

	 	'/newadmin')
   			echo "${REPLY[ID]}," >> settings/admins
   			send_markdown_message "${CHAT[ID]}" "${lang[ID]} ${REPLY[ID]} promoted to *admin*" "$reply"
     			;;

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
			
		'/gban')
			echo "[${DATE[YMD]} --> ${REPLY[FIRST_NAME]} ${REPLY[LAST_NAME]} @${REPLY[USERNAME]} (${REPLY[ID]})]" >> settings/gbans
			send_markdown_message "${CHAT[ID]}" "${lang[ID]} ${REPLY[ID]} *${lang[GBANNED]}.*"
			kick_chat_member "${CHAT[ID]}" "${REPLY[ID]}"
			;;

		'/ungban')
			sed -i "/${REPLY[ID]}/d" settings/gbans
			send_markdown_message "${CHAT[ID]}" "ID: ${REPLY[ID]} *${lang[UNGBANNED]}*."
			unban_chat_member "${CHAT[ID]}" "${REPLY[ID]}"
			;;
			
		'/infobot')
			send_markdown_message "${CHAT[ID]}" "*${lang[NAME]}* ${BOT[NAME]}
*${lang[USER]}* @${BOT[USERNAME]}
*${lang[ID]}* ${BOT[ID]}" "$reply"
			;;
		
		'/sudos')
			send_markdown_message "${CHAT[ID]}" "*Sudo users*
${ADMINS}"
			;;
		
		'/ip')	
			IP=$(curl -s http://api.ipify.org)
			send_markdown_message "${CHAT[ID]}" "IP Server: *$IP*"
		;;
	esac
    fi
fi
