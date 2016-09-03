#!/bin/bash
#*.*encoding=utf-8*.*

# Written by Drew (@topkecleon) and Daniil Gentili (@danogentili).
# More functions by @iicc1 and @jarriz.

# Set INLINE to 0 to disable inline queries.
# To enable this option in your bot, send the /setinline command to @BotFather.
# Get token and admin list.
TOKEN=$(cat settings/token)
ADMINS=$(cat settings/admins)
GBANS=$(cat settings/gbans)
INLINE=1

# Removing .folder file.
sudo rm settings/.folder &>/dev/null

if [ ! -f "/usr/bin/jq" ]; then echo "JQ not found... Installing..."; sudo apt-get install jq -y; echo "JQ has been downloaded. Proceeding...";
fi

if [ ! -f "settings/token" ]; then
	clear
	echo -e '\e[0;31mTOKEN MISSING.\e[0m'
	echo "PLEASE WRITE YOUR TOKEN HERE"
	read token
	echo "$token" >> settings/token
fi

if [ ! -f "settings/admins" ]; then
    echo "PLEASE WRITE YOUR ID HERE"
    read adminID
    echo "$adminID," >> settings/admins
fi

if [ ! -f "settings/gbans" ]; then
	touch settings/gbans
fi

source commands.sh source
URL='https://api.telegram.org/bot'$TOKEN


SCRIPT="$0"
MSG_URL=$URL'/sendMessage'
LEAVE_URL=$URL'/leaveChat'
KICK_URL=$URL'/kickChatMember'
UNBAN_URL=$URL'/unbanChatMember'
GETMEMBERS_URL=$URL'/getChatMembersCount'
GETMEMBER_URL=$URL'/getChatMember'
GETCHAT_URL=$URL'/getChat'
GETCHATADMIN=$URL'/getChatAdministrators'
PHO_URL=$URL'/sendPhoto'
AUDIO_URL=$URL'/sendAudio'
DOCUMENT_URL=$URL'/sendDocument'
STICKER_URL=$URL'/sendSticker'
VIDEO_URL=$URL'/sendVideo'
VOICE_URL=$URL'/sendVoice'
LOCATION_URL=$URL'/sendLocation'
VENUE_URL=$URL'/sendVenue'
ACTION_URL=$URL'/sendChatAction'
FORWARD_URL=$URL'/forwardMessage'
INLINE_QUERY=$URL'/answerInlineQuery'
ME_URL=$URL'/getMe'
ME_RES=$(curl -s $ME_URL)
ME=$(echo $ME_RES | jq -r '.result .username // empty')


FILE_URL='https://api.telegram.org/file/bot'$TOKEN'/'
UPD_URL=$URL'/getUpdates?offset='
GET_URL=$URL'/getFile'
OFFSET=0
declare -A USER CHAT MESSAGE URLS CONTACT LOCATION OUT_MEMBER NEW_MEMBER BOT REPLY MEMBERS iQUERY iUser FORWARD FORWARD_CHAT DATE ENTRY

urlencode() {
	echo "$*" | sed 's:%:%25:g;s: :%20:g;s:<:%3C:g;s:>:%3E:g;s:#:%23:g;s:{:%7B:g;s:}:%7D:g;s:|:%7C:g;s:\\:%5C:g;s:\^:%5E:g;s:~:%7E:g;s:\[:%5B:g;s:\]:%5D:g;s:`:%60:g;s:;:%3B:g;s:/:%2F:g;s:?:%3F:g;s^:^%3A^g;s:@:%40:g;s:=:%3D:g;s:&:%26:g;s:\$:%24:g;s:\!:%21:g;s:\*:%2A:g'
}

send_message() {
	[ "$2" = "" ] && return 1
	local chat="$1"
	local text="$(echo "$2" | sed 's/ mykeyboardstartshere.*//g;s/ myfilelocationstartshere.*//g;s/ mylatstartshere.*//g;s/ mylongstartshere.*//g;s/ mytitlestartshere.*//g;s/ myaddressstartshere.*//g')"
	local arg="$3"
	[ "$3" != "safe" ] && {
		local keyboard="$(echo "$2" | sed '/mykeyboardstartshere /!d;s/.*mykeyboardstartshere //g;s/ myfilelocationstartshere.*//g;s/ mylatstartshere.*//g;s/ mylongstartshere.*//g;s/ mytitlestartshere.*//g;s/ myaddressstartshere.*//g')"

		local file="$(echo "$2" | sed '/myfilelocationstartshere /!d;s/.*myfilelocationstartshere //g;s/ mykeyboardstartshere.*//g;s/ mylatstartshere.*//g;s/ mylongstartshere.*//g;s/ mytitlestartshere.*//g;s/ myaddressstartshere.*//g')"

		local lat="$(echo "$2" | sed '/mylatstartshere /!d;s/.*mylatstartshere //g;s/ mykeyboardstartshere.*//g;s/ myfilelocationstartshere.*//g;s/ mylongstartshere.*//g;s/ mytitlestartshere.*//g;s/ myaddressstartshere.*//g')"

		local long="$(echo "$2" | sed '/mylongstartshere /!d;s/.*mylongstartshere //g;s/ mykeyboardstartshere.*//g;s/ myfilelocationstartshere.*//g;s/ mylatstartshere.*//g;s/ mytitlestartshere.*//g;s/ myaddressstartshere.*//g')"

		local title="$(echo "$2" | sed '/mytitlestartshere /!d;s/.*mylongstartshere //g;s/ mykeyboardstartshere.*//g;s/ myfilelocationstartshere.*//g;s/ mylatstartshere.*//g;s/ myaddressstartshere.*//g')"

		local address="$(echo "$2" | sed '/myaddressstartshere /!d;s/.*mylongstartshere //g;s/ mykeyboardstartshere.*//g;s/ myfilelocationstartshere.*//g;s/ mylatstartshere.*//g;s/ mytitlestartshere.*//g')"

	}
	if [ "$keyboard" != "" ]; then
		send_keyboard "$chat" "$text" "$keyboard"
		local sent=y
	fi
	if [ "$file" != "" ]; then
		send_file "$chat" "$file" "$text"
		local sent=y
	fi
	if [ "$lat" != "" -a "$long" != "" -a "$address" = "" -a "$title" = "" ]; then
		send_location "$chat" "$lat" "$long"
		local sent=y
	fi
	if [ "$lat" != "" -a "$long" != "" -a "$address" != "" -a "$title" != "" ]; then
		send_venue "$chat" "$lat" "$long" "$title" "$address"
		local sent=y
	fi
	if [ "$sent" != "y" ];then
		send_text "$chat" "$text"
	fi

}

send_text() {
	case "$2" in
		html_parse_mode*)
			send_html_message "$1" "${2//html_parse_mode}"
			;;
		markdown_parse_mode*)
			send_markdown_message "$1" "${2//markdown_parse_mode}"
			;;
		*)
			res=$(curl -s "$MSG_URL" -d "chat_id=$1" -d "text=$(urlencode "$2")")
			;;
	esac
}

function send_register() {
	if [ "${CHAT[TYPE]}" == "private" ]; then
	 if [ "$MESSAGE" ]; then
	   echo -en '\n'
	   echo -e '\e[1;37m'$MESSAGE'\e[0m'
	   echo -en '\n'
	   echo -e '\e[1;34mPRIVATE\e[0m || \e[1;37mID\e[0m \e[0;36m'${USER[ID]}'\e[0m | \e[1;37mUser\e[0m \e[0;36m@'${USER[USERNAME]}'\e[0m | \e[1;37mFirstname\e[0m \e[0;36m'${USER[FIRST_NAME]} '\e[0m | \e[1;37mLastname\e[0m \e[0;36m'${USER[LAST_NAME]}'\e[0m'
	   echo ${DATE[ALL]}
	 fi
 	fi
 	
 	if [ "${CHAT[TYPE]}" != "private" ]; then
 	 if [ "$MESSAGE" ]; then
	   echo -en '\n'
	   echo -e '\e[1;37m'$MESSAGE'\e[0m'
	   echo -en '\n'
	   echo -e '\e[1;34mCHAT\e[0m || \e[1;37mID\e[0m \e[0;36m'${CHAT[ID]}'\e[0m | \e[1;37mTitle\e[0m \e[0;36m'${CHAT[TITLE]} '\e[0m'
	   echo -e '\e[1;34mFROM\e[0m || \e[1;37mID\e[0m \e[0;36m'${USER[ID]}'\e[0m | \e[1;37mUser\e[0m \e[0;36m@'${USER[USERNAME]}'\e[0m | \e[1;37mFirstname\e[0m \e[0;36m'${USER[FIRST_NAME]} '\e[0m | \e[1;37mLastname\e[0m \e[0;36m'${USER[LAST_NAME]}'\e[0m'
	   echo ${DATE[ALL]}
	 fi
	fi
	
	if [ "$NEW_MEMBER" ]; then
	   echo -en '\n'
	   echo -e '\e[1;33mNew member\e[0m | \e[1;37mID\e[0m \e[1;33m'${NEW_MEMBER[ID]}'\e[0m | \e[1;37mUser\e[0m \e[1;33m@'${NEW_MEMBER[USERNAME]}'\e[0m | \e[1;37mFirstname\e[0m \e[1;33m'${NEW_MEMBER[FIRST_NAME]}'\e[0m'
	   echo -en '\n'
	   echo -e '\e[1;34mCHAT\e[0m || \e[1;37mID\e[0m \e[0;36m'${CHAT[ID]}'\e[0m | \e[1;37mTitle\e[0m \e[0;36m'${CHAT[TITLE]} '\e[0m'
	   echo -e '\e[1;34mFROM\e[0m || \e[1;37mID\e[0m \e[0;36m'${USER[ID]}'\e[0m | \e[1;37mUser\e[0m \e[0;36m@'${USER[USERNAME]}'\e[0m | \e[1;37mFirstname\e[0m \e[0;36m'${USER[FIRST_NAME]} '\e[0m | \e[1;37mLastname\e[0m \e[0;36m'${USER[LAST_NAME]}'\e[0m'
	   echo ${DATE[ALL]}
	fi
	
	if [ "$OUT_MEMBER" ]; then
	   echo -en '\n'
	   echo -e '\e[1;33mMember out\e[0m | \e[1;37mID\e[0m \e[1;33m'${OUT_MEMBER[ID]}'\e[0m | \e[1;37mUser\e[0m \e[1;33m@'${OUT_MEMBER[USERNAME]}'\e[0m | \e[1;37mFirstname\e[0m \e[1;33m'${OUT_MEMBER[FIRST_NAME]}'\e[0m'
	   echo -en '\n'
	   echo -e '\e[1;34mCHAT\e[0m || \e[1;37mID\e[0m \e[0;36m'${CHAT[ID]}'\e[0m | \e[1;37mTitle\e[0m \e[0;36m'${CHAT[TITLE]} '\e[0m'
	   echo -e '\e[1;34mFROM\e[0m || \e[1;37mID\e[0m \e[0;36m'${USER[ID]}'\e[0m | \e[1;37mUser\e[0m \e[0;36m@'${USER[USERNAME]}'\e[0m | \e[1;37mFirstname\e[0m \e[0;36m'${USER[FIRST_NAME]} '\e[0m | \e[1;37mLastname\e[0m \e[0;36m'${USER[LAST_NAME]}'\e[0m'
	   echo ${DATE[ALL]}
	fi

	if [ "$GBAN" == "1" ]; then
	   echo -en '\n'
	   echo -e '\e[0;31mID '${USER[ID]}' is gbanned.\e[0m'
	fi

	if [ "${iQUERY[MSG]}" ]; then
	   echo 'iQuery msg ('${iQUERY[MSG]}')'
	fi
}

send_markdown_message() {
	res=$(curl -s "$MSG_URL" -d "chat_id=$1" -d "text=$(urlencode "$2")" -d "parse_mode=markdown" -d "disable_web_page_preview=true" -d "reply_to_message_id=$3")
}

send_silently_message() {
	res=$(curl -s "$MSG_URL" -d "chat_id=$1" -d "text=$(urlencode "$2")" -d "parse_mode=markdown" -d "disable_web_page_preview=true" -d "disable_notification=true" -d "reply_to_message_id=$3")
}

send_html_message() {
	res=$(curl -s "$MSG_URL" -d "chat_id=$1" -d "text=$(urlencode "$2")" -d "parse_mode=html" -d "disable_web_page_preview=true" -d "reply_to_message_id=$3")
}

kick_chat_member() {
	res=$(curl -s "$KICK_URL" -F "chat_id=$1" -F "user_id=$2")
}

unban_chat_member() {
	res=$(curl -s "$UNBAN_URL" -F "chat_id=$1" -F "user_id=$2")
}

leave_chat() {
 res=$(curl -s "$LEAVE_URL" -F "chat_id=$1")
}

getchat() {
	res=$(curl -s "$GETCHAT_URL" -d "chat_id=$1")
}

send_inline_keyboard() {
res=$(curl "$MSG_URL" -d "chat_id=$1" -d "text=$2" -d "reply_markup=$3" -d "reply_to_message_id=$4" -d "disable_web_page_preview=true" -d "parse_mode=markdown")
}

answer_inline_query() {
	case $2 in
		"article")
			InlineQueryResult='[{"type":"'$2'","id":"'$RANDOM'","title":"'$3'","message_text":"'$4'","description":"'$5'","thumb_url":"'$6'","parse_mode":"markdown"}]'
		;;
		"photo")
			InlineQueryResult='[{"type":"'$2'","id":"'$RANDOM'","photo_url":"'$3'","thumb_url":"'$4'"}]'
		;;
		"gif")
			InlineQueryResult='[{"type":"'$2'","id":"'$RANDOM'","gif_url":"'$3'", "thumb_url":"'$4'"}]'
		;;
		"mpeg4_gif")
			InlineQueryResult='[{"type":"'$2'","id":"'$RANDOM'","mpeg4_url":"'$3'"}]'
		;;
		"video")
			InlineQueryResult='[{"type":"'$2'","id":"'$RANDOM'","video_url":"'$3'","mime_type":"'$4'","thumb_url":"'$5'","title":"'$6'"}]'
		;;
		"audio")
			InlineQueryResult='[{"type":"'$2'","id":"'$RANDOM'","audio_url":"'$3'","title":"'$4'"}]'
		;;
		"voice")
			InlineQueryResult='[{"type":"'$2'","id":"'$RANDOM'","voice_url":"'$3'","title":"'$4'"}]'
		;;
		"document")
			InlineQueryResult='[{"type":"'$2'","id":"'$RANDOM'","title":"'$3'","caption":"'$4'","document_url":"'$5'","mime_type":"'$6'"}]'
		;;
		"location")
			InlineQueryResult='[{"type":"'$2'","id":"'$RANDOM'","latitude":"'$3'","longitude":"'$4'","title":"'$5'"}]'
		;;
		"venue")
			InlineQueryResult='[{"type":"'$2'","id":"'$RANDOM'","latitude":"'$3'","longitude":"'$4'","title":"'$5'","address":"'$6'"}]'
		;;
		"contact")
			InlineQueryResult='[{"type":"'$2'","id":"'$RANDOM'","phone_number":"'$3'","first_name":"'$4'"}]'
		;;

		# Cached media stored in Telegram server

		"cached_photo")
			InlineQueryResult='[{"type":"photo","id":"'$RANDOM'","photo_file_id":"'$3'"}]'
		;;
		"cached_gif")
			InlineQueryResult='[{"type":"gif","id":"'$RANDOM'","gif_file_id":"'$3'"}]'
		;;
		"cached_mpeg4_gif")
			InlineQueryResult='[{"type":"mpeg4_gif","id":"'$RANDOM'","mpeg4_file_id":"'$3'"}]'
		;;
		"cached_sticker")
			InlineQueryResult='[{"type":"sticker","id":"'$RANDOM'","sticker_file_id":"'$3'"}]'
		;;
		"cached_document")
			InlineQueryResult='[{"type":"document","id":"'$RANDOM'","title":"'$3'","document_file_id":"'$4'"}]'
		;;
		"cached_video")
			InlineQueryResult='[{"type":"video","id":"'$RANDOM'","video_file_id":"'$3'","title":"'$4'"}]'
		;;
		"cached_voice")
			InlineQueryResult='[{"type":"voice","id":"'$RANDOM'","voice_file_id":"'$3'","title":"'$4'"}]'
		;;
		"cached_audio")
			InlineQueryResult='[{"type":"audio","id":"'$RANDOM'","audio_file_id":"'$3'"}]'
		;;

	esac

	res=$(curl -s "$INLINE_QUERY" -F "inline_query_id=$1" -F "results=$InlineQueryResult")

}

send_keyboard() {
	local chat="$1"
	local text="$2"
	shift 2
	local keyboard=init
	OLDIFS=$IFS
	IFS=$(echo -en "\"")
	for f in $*;do [ "$f" != " " ] && local keyboard="$keyboard, [\"$f\"]";done
	IFS=$OLDIFS
	local keyboard=${keyboard/init, /}
	res=$(curl -s "$MSG_URL" --header "content-type: multipart/form-data" -F "chat_id=$chat" -F "text=$text" -F "reply_markup={\"keyboard\": [$keyboard],\"one_time_keyboard\": true}")
}

get_file() {
	[ "$1" != "" ] && echo $FILE_URL$(curl -s "$GET_URL" -F "file_id=$1" | jq -r '.result .file_path // empty')
}

send_file() {
	[ "$2" = "" ] && return
	local chat_id=$1
	local file=$2
	echo "$file" | grep -qE $FILE_REGEX || return
	local ext="${file##*.}"
	case $ext in
        	mp3|flac)
			CUR_URL=$AUDIO_URL
			WHAT=audio
			STATUS=upload_audio
			local CAPTION="$3"
			;;
		png|jpg|jpeg|gif)
			CUR_URL=$PHO_URL
			WHAT=photo
			STATUS=upload_photo
			local CAPTION="$3"
			;;
		webp)
			CUR_URL=$STICKER_URL
			WHAT=sticker
			STATUS=
			;;
		mp4|3GP)
			CUR_URL=$VIDEO_URL
			WHAT=video
			STATUS=upload_video
			local CAPTION="$3"
			;;

		ogg)
			CUR_URL=$VOICE_URL
			WHAT=voice
			STATUS=
			;;
		*)
			CUR_URL=$DOCUMENT_URL
			WHAT=document
			STATUS=upload_document
			local CAPTION="$3"
			;;
	esac
	send_action $chat_id $STATUS
	res=$(curl -s "$CUR_URL" -F "chat_id=$chat_id" -F "$WHAT=@$file" -F "caption=$CAPTION")
}

# typing for text messages, upload_photo for photos, record_video or upload_video for videos, record_audio or upload_audio for audio files, upload_document for general files, find_location for location

send_action() {
	[ "$2" = "" ] && return
	res=$(curl -s "$ACTION_URL" -F "chat_id=$1" -F "action=$2")
}

send_location() {
	[ "$3" = "" ] && return
	res=$(curl -s "$LOCATION_URL" -F "chat_id=$1" -F "latitude=$2" -F "longitude=$3")
}

send_venue() {
	[ "$5" = "" ] && return
	[ "$6" != "" ] add="-F \"foursquare_id=$6\""
	res=$(curl -s "$VENUE_URL" -F "chat_id=$1" -F "latitude=$2" -F "longitude=$3" -F "title=$4" -F "address=$5" $add)
}

getmembers() {
	members=$(curl -s "${GETMEMBERS_URL}" -d "chat_id=$1" | cut -d ":" -f3 | cut -d "}" -f1)
	send_markdown_message "$1" "$2$members"
}

forward() {
	[ "$3" = "" ] && return
	res=$(curl -s "$FORWARD_URL" -F "chat_id=$1" -F "from_chat_id=$2" -F "message_id=$3")
}

db_get() {
	redis-bash-cli -h localhost GET $1
}

db_set() {
	redis-bash-cli -h localhost SET "$1" "$2"
}

db_del() {
	redis-bash-cli -h localhost SET "$1" 0
}

db_exist() {
	check_db=$(db_get $1)
	if [ "$check_db" == 0 ]; then
		exit
	else
		echo $check_db
	fi
}

startproc() {
	killproc
	mkfifo /tmp/$copname
	TMUX= tmux new-session -d -s $copname "$* &>/tmp/$copname; echo imprettydarnsuredatdisisdaendofdacmd>/tmp/$copname"
	TMUX= tmux new-session -d -s sendprocess_$copname "bash $SCRIPT outproc ${CHAT[ID]} $copname"
}

killproc() {
	(tmux kill-session -t $copname; echo imprettydarnsuredatdisisdaendofdacmd>/tmp/$copname; tmux kill-session -t sendprocess_$copname; rm -r /tmp/$copname)2>/dev/null
}

inproc() {
	tmux send-keys -t $copname "$MESSAGE ${URLS[*]}
"
}

set_lang() {
 source lang.sh
 var=false
  for all in ${!Langs[@]}; do
	setlng=$(echo ${ENTRY[1]} | tr [:upper:] [:lower:])
	if [ "${setlng}" = "${Langs[$all]}" ]; then
		var=true
	fi
  done
echo $var
}

process_client() {
	# Message
	MESSAGE=$(echo "$res" | jq -r '.result[0] .message .text // empty')
	MESSAGE[ID]=$(echo "$res" | jq -r '.result[0] .message .message_id // empty')
	
	# Forward from user
	FORWARD=$(echo "$res" | jq -r '.result[0] .message .forward_from // empty')
	FORWARD[ID]=$(echo "$res" | jq -r '.result[0] .message .forward_from .id // empty')
	FORWARD[FIRST_NAME]=$(echo "$res" | jq -r '.result[0] .message .forward_from .first_name // empty')
	FORWARD[LAST_NAME]=$(echo "$res" | jq -r '.result[0] .message .forward_from .last_name // empty')
	FORWARD[USERNAME]=$(echo "$res" | jq -r '.result[0] .message .forward_from .username // empty')
	
	# Forward from chat (channel)
	FORWARD_CHAT=$(echo "$res" | jq -r '.result[0] .message .forward_from_chat // empty')
	FORWARD_CHAT[ID]=$(echo "$res" | jq -r '.result[0] .message .forward_from_chat .id // empty')
	FORWARD_CHAT[TITLE]=$(echo "$res" | jq -r '.result[0] .message .forward_from_chat .title // empty')
	FORWARD_CHAT[USERNAME]=$(echo "$res" | jq -r '.result[0] .message .forward_from_chat .username // empty')
	
	# Generate reply
	reply=$(echo "$res" | jq -r '.result[0] .message .message_id // empty')
	
	# Bot
	BOT[USERNAME]=$(echo $ME_RES | jq -r '.result .username // empty')
	BOT[NAME]=$(echo $ME_RES | jq -r '.result .first_name // empty')
	BOT[ID]=$(echo $ME_RES | jq -r '.result .id // empty')

	# Get user data by reply
	REPLY[ID]=$(echo "$res" | jq -r '.result[0] .message .reply_to_message .from .id // empty')
	REPLY[FIRST_NAME]=$(echo "$res" | jq -r '.result[0] .message .reply_to_message .from .first_name // empty')
	REPLY[LAST_NAME]=$(echo "$res" | jq -r '.result[0] .message .reply_to_message .from .last_name // empty')
	REPLY[USERNAME]=$(echo "$res" | jq -r '.result[0] .message .reply_to_message .from .username // empty')
	
	# Chat
	CHAT[ID]=$(echo "$res" | jq -r '.result[0] .message.chat .id // empty')
	CHAT[TITLE]=$(echo "$res" | jq -r '.result[0] .message .chat .title // empty')
	CHAT[TYPE]=$(echo "$res" | jq -r '.result[0] .message .chat .type // empty')
	
	# User
	USER[ID]=$(echo "$res" | jq -r '.result[0] .message .from .id // empty')
	USER[FIRST_NAME]=$(echo "$res" | jq -r '.result[0] .message .from .first_name // empty')
	USER[LAST_NAME]=$(echo "$res" | jq -r '.result[0] .message .from .last_name // empty')
	USER[USERNAME]=$(echo "$res" | jq -r '.result[0] .message .from .username // empty')
	
	# Inline data
	iUSER[ID]=$(echo "$res" | jq -r '.result[0] .inline_query .from .id // empty')
	iUSER[FIRST_NAME]=$(echo "$res" | jq -r '.result[0] .inline_query .from .first_name // empty')
	iUSER[LAST_NAME]=$(echo "$res" | jq -r '.result[0] .inline_query .from .last_name // empty')
	iUSER[USERNAME]=$(echo "$res" | jq -r '.result[0] .inline_query .from .username // empty')
	iQUERY[ID]=$(echo "$res" | jq -r '.result[0] .inline_query .id // empty')
	iQUERY[MSG]=$(echo "$res" | jq -r '.result[0] .inline_query .query // empty')
	
	# New members added/joined
	NEW_MEMBER=$(echo "$res" | jq -r '.result[0] .message .new_chat_member // empty')
	NEW_MEMBER[ID]=$(echo "$res" | jq -r '.result[0] .message .new_chat_member .id // empty')
	NEW_MEMBER[FIRST_NAME]=$(echo "$res" | jq -r '.result[0] .message .new_chat_member .first_name // empty')
	NEW_MEMBER[LAST_NAME]=$(echo "$res" | jq -r '.result[0] .message .new_chat_member .last_name // empty')
	NEW_MEMBER[USERNAME]=$(echo "$res" | jq -r '.result[0] .message .new_chat_member .username // empty')
	
	# Members kicked/out
	OUT_MEMBER=$(echo "$res" | jq -r '.result[0] .message .left_chat_member // empty')
	OUT_MEMBER[ID]=$(echo "$res" | jq -r '.result[0] .message .left_chat_member .id // empty')
	OUT_MEMBER[FIRST_NAME]=$(echo "$res" | jq -r '.result[0] .message .left_chat_member .first_name // empty')
	OUT_MEMBER[LAST_NAME]=$(echo "$res" | jq -r '.result[0] .message .left_chat_member .last_name // empty')
	OUT_MEMBER[USERNAME]=$(echo "$res" | jq -r '.result[0] .message .left_chat_member .username // empty')
	
	# Audio
	URLS[AUDIO]=$(get_file $(echo "$res" | jq -r '.result[0] .message .audio .file_id // empty'))
	# Document
	URLS[DOCUMENT]=$(get_file $(echo "$res" | jq -r '.result[0] .message .document .file_id // empty'))
	# Photo
	URLS[PHOTO]=$(get_file $(echo "$res" | jq -r '.result[0] .message .photo .file_id // empty'))
	# Sticker
	URLS[STICKER]=$(get_file $(echo "$res" | jq -r '.result[0] .message .sticker .file_id // empty'))
	# Video
	URLS[VIDEO]=$(get_file $(echo "$res" | jq -r '.result[0] .message .video .file_id // empty'))
	# Voice
	URLS[VOICE]=$(get_file $(echo "$res" | jq -r '.result[0] .message .voice .file_id // empty'))

	# Contact
	CONTACT[NUMBER]=$(echo "$res" | jq -r '.result[0] .message .contact .phone_number // empty')
	CONTACT[FIRST_NAME]=$(echo "$res" | jq -r '.result[0] .message .contact .first_number // empty')
	CONTACT[LAST_NAME]=$(echo "$res" | jq -r '.result[0] .message .contact .last_number // empty')
	CONTACT[USER_ID]=$(echo "$res" | jq -r '.result[0] .message .contact .user_id // empty')

	# Other services
	DELETE_CHAT_PHOTO=$(echo "$res" | jq -r '.result[0] .message .delete_chat_photo // empty')

	# Get entries
	ENTRY[ALL]=$(echo $MESSAGE | cut -d " " -f2- )

	ENTRY[1]=$(echo $MESSAGE | cut -d " " -f2 )
	ENTRY[1-]=$(echo $MESSAGE | cut -d " " -f2- )

	ENTRY[2]=$(echo $MESSAGE | cut -d " " -f3 )
	ENTRY[2-]=$(echo $MESSAGE | cut -d " " -f3- )

	ENTRY[3]=$(echo $MESSAGE | cut -d " " -f4 )
	ENTRY[3-]=$(echo $MESSAGE | cut -d " " -f4- )

	ENTRY[4]=$(echo $MESSAGE | cut -d " " -f5 )
	ENTRY[4-]=$(echo $MESSAGE | cut -d " " -f5- )

	ENTRY[5]=$(echo $MESSAGE | cut -d " " -f6 )
	ENTRY[5-]=$(echo $MESSAGE | cut -d " " -f6- )

	# Date
	DATE[ALL]=$(date)
	DATE[IN_FORMAT]=$(date +%H:%M:%S\ %d/%m/%Y)
	DATE[YMD]=$(date +%F)
	DATE[SECOND]=$(date +%S)
	DATE[MINUTE]=$(date +%M)
	DATE[HOUR]=$(date +%T)
	DATE[DAY]=$(date +%A)
	DATE[MOUNT]=$(date +%m)
	DATE[YEAR]=$(date +%Y)

	# Caption
	CAPTION=$(echo "$res" | jq -r '.result[0] .message .caption // empty')

	# Location
	LOCATION[LONGITUDE]=$(echo "$res" | jq -r '.result[0] .message .location .longitude // empty')
	LOCATION[LATITUDE]=$(echo "$res" | jq -r '.result[0] .message .location .latitude // empty')
	NAME="$(echo ${URLS[*]} | sed 's/.*\///g')"

	# Tmux
	copname="$ME"_"${CHAT[ID]}"
	
	# Read admins bot
	echo $ADMINS | grep ${USER[ID]} &>/dev/null
	if [ $? == 0 ]; then
		ADMIN=1
	else
		ADMIN=0
	fi
	
	# Read list of gbans
	echo $GBANS | grep ${USER[ID]} &>/dev/null
 	if [ $? == 0 ]; then
 		GBAN=1
 	else
 		if [ ! -z "${NEW_MEMBER[ID]}" ]; then
 			echo $GBANS | grep ${NEW_MEMBER[ID]}
 			if [ $? == 0 ]; then
 				GBAN=1
 			fi
 		   fi
 		GBAN=0
 	fi
	
	source commands.sh

	tmpcount="COUNT${CHAT[ID]}"
	cat count | grep -q "$tmpcount" || echo "$tmpcount">>count
	# To get user count execute bash bashbot.sh count
}

# source the script with source as param to use functions in other scripts
while [ "$1" == "startbot" ]; do {

	res=$(curl -s $UPD_URL$OFFSET )

	# Offset
	OFFSET=$(echo "$res" | jq -r '.result[0].update_id')
	OFFSET=$((OFFSET+1))

	if [ $OFFSET != 1 ]; then
		if [ "$2" == "test" ]; then
 			process_client
 		else
 			process_client&
 		fi
	fi

}; done


case "$1" in
	"outproc")
		until [ "$line" = "imprettydarnsuredatdisisdaendofdacmd" ];do
			line=
			read -t 10 line
			[ "$line" != "" -a "$line" != "imprettydarnsuredatdisisdaendofdacmd" ] && send_message "$2" "$line"
		done </tmp/$3
		rm -r /tmp/$3
		;;

	"count")
		echo "A total of $(wc -l count | sed 's/count//g')users used me."
		;;

	"broadcast")
		echo "Sending the broadcast $* to $(wc -l count | sed 's/count//g')users."
		[ $(wc -l count | sed 's/ count//g') -gt 300 ] && sleep="sleep 0.5"
		shift
		for f in $(cat count);do send_markdown_message ${f//COUNT} "$*"; $sleep;done
		;;

	"tmux")
		clear
		tmux kill-session -t $ME&>/dev/null
		tmux new-session -d -s $ME "bash $SCRIPT startbot" && echo -e '\e[0;32mBot started successfully.\e[0m'
		echo "Tmux session name $ME" || echo -e '\e[0;31mAn error occurred while starting the bot. \e[0m'
		date=$(date +%H:%M:%S\ %d/%m/%Y)
send_silently_message "${ADMINS}" "*Bot started*
*Session* \`*TMUX* - ${ME}\`
*Date* \`$date\`"
		;;

	"kill")
		clear
		tmux kill-session -t $ME &>/dev/null
		send_silently_message "${ADMINS}" "*Bot stopped*"
		echo -e '\e[0;32mOK. Bot stopped successfully.\e[0m'
		;;
		
	
	"api")
		clear
		echo -e '\e[0;36m-----------------------------------------\e[0m'
		echo -e '\e[0;36m---------------Change API----------------\e[0m'
		echo -e '\e[0;36m-----------------------------------------\e[0m'
		echo -e '\e[1;33m           select your option     \e[0m'
		echo ' '
		echo ' '
		echo '1- Change pwrtelegram api to telegram api'
		echo '2- Change telegram api to pwrtelegram api'

		read api

		if [ $api == 1 ]; then
		  clear
		  sed -i 's/api\.pwrtelegram\.xyz/api\.telegram\.org/g' bot.sh
		  echo -e '\e[0;32mOK. Change sucessfully. (pwrtelegram to telegram)\e[0m'
		fi

		if [ $api == 2 ]; then
		  clear
		  sed -i 's/api\.telegram\.org/api\.pwrtelegram\.xyz/g' bot.sh
		  echo -e '\e[0;32mOK. Change sucessfully. (telegram to pwrtelegram)\e[0m'
		fi
	;;


	"help")
		if [ ! -f "/usr/bin/elinks" ]; then sudo apt-get install elinks -y; fi
		clear
		elinks https://github.com/iicc1/TgBash/wiki
		;;

	"attach")
		tmux attach -t $ME
		;;
	
	"args")
		clear
		echo "Available arguments: outproc, count, broadcast, start, kill, help, attach"
		;;

	*)
		tmux kill-session -t $ME &>/dev/null
		date=$(date +%H:%M:%S\ %d/%m/%Y)
send_silently_message "${ADMINS}" "*Bot started*
*Session* \`*Normal session*\`
*Date* \`$date\`" && echo "BOT STARTED IN NORMAL SESSION @$ME"
		source bot.sh startbot
		;;
esac
