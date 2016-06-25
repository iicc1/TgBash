declare -A inline_keyboard

# Inline keyboards with links

inline_keyboard[help]='{"inline_keyboard":[
			[{"text":"🔜Github","url":"'https://github.com/iicc1/TgBash'"},
			{"text":"📢 Channel","url":"'https://telegram.me/TgBash'"}]
			]}'

inline_keyboard[example1]='{"inline_keyboard":[
			[{"text":"JUST A KEYBOARD","url":"'https://google.com'"}]}'
			
inline_keyboard[example2]='{"inline_keyboard":[
			[{"text":"KEYBOARD 1","url":"'https://google.com'"}],
			[{"text":"OTHER KEYBOARD LEFT","url":"'https://google.com'"}]
			]}'
			
inline_keyboard[example3]='{"inline_keyboard":[
			[{"text":"KEYBOARD 1 -","url":"'https://google.com'"},
			{"text":"OTHER KEYBOARD DOWN","url":"'https://google.com'"}]
			]}'