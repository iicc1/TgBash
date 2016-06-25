declare -A inline_keyboard

# Inline keyboards with links

inline_keyboard[help]='{"inline_keyboard":[
			[{"text":"🔜Github","url":"'https://github.com/iicc1/TgBash'"},
			{"text":"📢 Channel","url":"'https://telegram.me/TgBash'"}]
			]}'

inline_keyboard[example1]='{"inline_keyboard":[
			[{"text":"JUST A KEYBOARD","url":"'https://google.com'"}]
			]}'
			
inline_keyboard[example2]='{"inline_keyboard":[
 			[{"text":"UP","url":"'https://google.com'"}],
 			[{"text":"DOWN","url":"'https://google.com'"}]
 			]}'
 
inline_keyboard[example3]='{"inline_keyboard":[
			[{"text":"LEFT","url":"'https://google.com'"},
			{"text":"RIGHT","url":"'https://google.com'"}]
			]}'
