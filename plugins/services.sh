send_register # load chat register
source lang.sh # load langs

if ! tmux ls | grep -v send | grep -q $copname; then
	[ ! -z ${URLS[*]} ] && {
	curl -s ${URLS[*]} -o $NAME
		send_file "${CHAT[ID]}" "$NAME" "$CAPTION"
		rm "$NAME"
	}
	[ ! -z ${LOCATION[*]} ] && send_location "${CHAT[ID]}" "${LOCATION[LATITUDE]}" "${LOCATION[LONGITUDE]}"

# Inline
if [ $INLINE == "on" ]; then
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


# If is new member then

if [ "$GET_WELCOME" == "on" ]; then

 if [ "$NEW_MEMBER" ]; then
	welcome=$(db_exist welcome)
	if [ "$welcome" ]; then
		send_markdown_message "${CHAT[ID]}" "$welcome"
	else
		send_markdown_message "${CHAT[ID]}" "Welcome ${NEW_MEMBER[FIRST_NAME]} @${NEW_MEMBER[USERNAME]} to *${CHAT[TITLE]}*"
	fi
 fi

fi
	
# If is out then

if [ "$GET_LEFT" == "on" ]; then

 if [ "$OUT_MEMBER" ]; then
	send_markdown_message "${CHAT[ID]}" "Bye @${OUT_MEMBER[USERNAME]}, I see you later..."
 fi

fi
	
# If forward

if [ "$GET_FORWARDS" == "on" ]; then

 if [ "$FORWARD" ] || [ "$FORWARD_CHAT" ]; then
	if [ "${CHAT[TYPE]}" == private ]; then
		if [ ${FORWARD[ID]} ]; then
			send_markdown_message "${CHAT[ID]}" "*${lang[ID]}* ${FORWARD[ID]}" "$reply"
		fi
		if [ ${FORWARD_CHAT[ID]} ]; then
			send_markdown_message "${CHAT[ID]}" "${lang[CHANNEL_ID]} ${FORWARD_CHAT[ID]}
*${lang[TITLE]}* ${FORWARD_CHAT[TITLE]}
*${lang[USER]}* \`@${FORWARD_CHAT[USERNAME]}\`" "$reply"
		fi
	fi
  exit
 fi

fi


if [ "$KICK_GBANS" == "on" ]; then
 user_globally_banned=$(user_is_gbanned)
 if [ $user_globally_banned ]; then
	kick_chat_member "${CHAT[ID]}" "$user_globally_banned"
	exit 
 fi
fi