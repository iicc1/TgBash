TOKEN="" # Your token here
FILE_REGEX="/"

GLOBAL_LANG='en'

Owners=(
	0
	)

Langs=(
	"en"
	"es"
	"ru"
	)

Plugins=(
	"services.sh"
	"admins.sh"
	"owners.sh"
	"users.sh"
)


# Settings. Disable with "off"

INLINE="on"
GET_FORWARDS="on"
GET_WELCOME="on"
GET_LEFT="on"
KICK_GBANS="on"

# Redis settins
redis_server='localhost'
redis_db='telegram'
redis_port=6379

# HASHS OF REDIS
AHASH="GROUP:${CHAT[ID]}:ADMINS"
WHASH="GROUP:${CHAT[ID]}:WELCOME"
LHASH="GROUP:${CHAT[ID]}:LANG"

# Telegram settings
test=false
