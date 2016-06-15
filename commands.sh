#!/bin/bash
#*.*encoding=utf-8*.*

# Edit your commands in this file.
if [ "$1" = "source" ];then
	FILE_REGEX='/'
else
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
				answer_inline_query "${iQUERY[ID]}" "article" "GitHub" "This is a bot bash. Get code [here](https://github.com/iicc1/TgBash)"
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
	  # If is gbanned then
	if [ $GBAN == 1 ]; then
		kick_chat_member "${CHAT[ID]}" "${GBAN}"
		send_markdown_message "${CHAT[ID]}" "User in list of *users globally banned*.
TAKE *CARE*."
		echo "User is banned"
		exit 
	fi
	
	# User commands
    	echo $MESSAGE | grep "^/echo"
        if [ $? == 0 ]; then
	 MESSAGE=$(echo $MESSAGE | cut -d " " -f2-)
		send_markdown_message "${CHAT[ID]}" "$MESSAGE"
	fi
	
	echo $MESSAGE | grep "^/calc"
        if [ $? == 0 ]; then
	 MESSAGE=$(echo $MESSAGE | cut -d " " -f2-)
	 EXPR=$(expr $MESSAGE | bc)
		send_markdown_message "${CHAT[ID]}" "*${EXPR}*" "$reply"
    	fi

	case $MESSAGE in
		'/start' | '/help')
		if [ ${CHAT[TYPE]} == private ]; then
			send_action "${CHAT[ID]}" "typing"
			start_inline_keyboard "${CHAT[ID]}" "Hi everybody! 
This is a *bot* written in code *shell*
More functions made by @iicc1 and @Jarriz.

*Commands*
 *Users*:
  /start or /help _Start bot and get this message_.
  /info _Get shorter info message about this bot_.
  /getinfo <by reply> _Get info user by reply_.
  /question _Start interactive chat_.
  /cancel _Cancel any currently running interactive chats_.
  /echo <text> _The bot will send a echo message (markdown compatible)_.
  /myinfo _The bot will send your info user_.
  /getmembers _The bot will you send the count of members in the chat_.
  /calc <expr> _The bot will calculate the expression_.
  /kickme _You will be autokicked from the chat_.
  
 *Admin*:
  /leavechat _The bot will leave the group with this command_.
  /broadcast <text> _The bot will send a broadcast (markdown compatible)_.
  /kick <by reply> _The bot will kick the user by reply (the user can back again)_.
  /ban <by reply> _The bot will ban the user by reply (the user cant back again)_.
  /unban <by reply> _The bot will unban the user by reply if is banned_.
  /infobot _The bot will reply the information of the bot_.
  /gban <by reply> _The user replied will be banned_.
  /ungban <by reply> _The user replied will be unbanned_.
  
*Based* in [telegram-bot-bash](http://github.com/topkecleon/telegram-bot-bash)"
		
		fi
	# If command /start isn't in private then
		if [ ${CHAT[TYPE]} != private ]; then
	send_markdown_message "${CHAT[ID]}" "This command *only works* in *private*."
		fi
			;;
			
		'/question')
			startproc "./question"
			;;
		
		'/getinfo')
			send_markdown_message "${CHAT[ID]}" "*User* @${REPLY[USERNAME]}
*ID* ${REPLY[ID]}" "$reply"
			;;
			
		'/info')
			send_markdown_message "${CHAT[ID]}" "This is a bashbot of *Telegram* written entirely in *bash*.
More info [here](https://github.com/iicc1/TgBash)" "$reply"
			;;
     			
     		'/kickme')
     			kick_chat_member "${CHAT[ID]}" "${USER[ID]}"
     			unban_chat_member "${CHAT[ID]}" "${USER[ID]}"
     			;;
     			
     		'/myinfo')
			send_markdown_message "${CHAT[ID]}" "*ID* ${USER[ID]}
*User* @${USER[USERNAME]}
*Name* ${USER[FIRST_NAME]}
*Last name* ${USER[LAST_NAME]}"
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
    	
	case $MESSAGE in
	 	'/leavechat')
			send_markdown_message "${CHAT[ID]}" "*CHAT LEAVED*"
   			leave_chat "${CHAT[ID]}"
     			;;

	 	'/newadmin')
   			echo "${REPLY[ID]}," >> settings/admins
   			send_markdown_message "${CHAT[ID]}" "ID ${REPLY[ID]} promoted to *admin*" "$reply"
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
			date=$(date)
			echo "[$date --> ${REPLY[FIRST_NAME]} ${REPLY[LAST_NAME]} @${REPLY[USERNAME]} (${REPLY[ID]})]" >> settings/gbans
			send_markdown_message "${CHAT[ID]}" "ID: ${REPLY[ID]} *globally banned.*"
			kick_chat_member "${CHAT[ID]}" "${REPLY[ID]}"
			;;

		'/ungban')
			sed -i "/${REPLY[ID]}/d" settings/gbans
			send_markdown_message "${CHAT[ID]}" "ID: ${REPLY[ID]} *globally unbanned*."
			unban_chat_member "${CHAT[ID]}" "${REPLY[ID]}"
			;;
			
		'/infobot')
			send_markdown_message "${CHAT[ID]}" "*Name* ${BOT[NAME]}
*Username* @${BOT[USERNAME]}
*ID* ${BOT[ID]}" "$reply"
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
