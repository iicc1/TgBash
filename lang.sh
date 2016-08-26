#!/bin/bash
#*.*encoding=utf-8*.*

declare -a langs
# Select your language
LANG='en' # Reemplace to your code of language (if is available)

# Availables langs
langs=(
	"ES" "es"
	"EN" "en"
	)

# If the lang is ES then
if [ $LANG == 'ES' ] || [ $LANG == 'es' ]; then
declare -A lang

  lang[START]='¡Hola a todos! 
Este es un bot escrito en código *bash*.
Más funciones hechas por @iicc1 y @Jarriz.

*Comandos*
 *Usuarios*:
  /start ó /help `Inicia el bot con este mensaje`.
  /info `Obtiene un mensaje corto acerca de este bot`.
  /getinfo <_por respuesta_> `Obtiene la información del usuario respondido`.
  /calculator `Comienza una calculadora interactiva`.
  /cancel `Cancela cualquier acción interactiva`.
  /echo <_texto_> `El bot repetirá el texto ingresado (markdown compatible)`.
  /myinfo `El bot enviará tu información de usuario`.
  /getmembers `El bot enviará la cuenta de miembros en el chat actual`.
  /calc <_expr_> `El bot calculará cualquier expresión ingresada`.
  /kickme `Serás autoexpulsado del chat actual`.
  /ct <_mensaje_> `Envia un mensaje a los admins del bot`.
  
 *Administradores*:
  /leavechat `El bot abandonará el chat con este comando`.
  /broadcast <_texto_> `El bot enviará un broadcast (markdown compatible)`.
  /kick <_por respuesta_> `El bot expulsará al usuario respondido (el usuario podrá regresar)`.
  /ban <_por respuesta_> `El bot baneará al usuario respondido (el usuario no podrá regresar)`.
  /unban <_por respuesta_> `El bot desbaneará al usuario respondido`.
  /infobot `El bot responderá con la información del mismo`.
  /su <_comando_> `Arranca un comando devolviendo la respuesta`.
  /ip `El bot enviará la IP del servidor`.
  /gban <_por respuesta_> `EL usuario respondido será globalmente baneado`.
  /ungban <_por respuesta_> `EL usuario respondido será globalmente desbaneado`.
  
*Basado* en [telegram-bot-bash](http://github.com/topkecleon/telegram-bot-bash)'
  
  lang[INFO]='Este es un bot de *Telegram* escrito completamente en bash.
Obtén el código [aquí](https://github.com/iicc1/TgBash)'

  lang[USER]='Usuario'
  
  lang[NAME]='Nombre'
  
  lang[LASTNAME]='Apellido'
  
  lang[GBANNED]='globalmente baneado'
  
  lang[UNGBANNED]='globalmente desbaneado'
  
  lang[ID]='ID'

  lang[LANG_NO_AVAILABLE]="El lenguaje \"*${ENTRY[1]}*\" no está disponible"
  
  lang[CHANNEL_ID]='*ID del canal*'
  
  lang[IP]='La IP del servidor es:'
  
  lang[PRIVATE]='Este comando *sólo funciona* en *privado*.'
  
  lang[LANG]='Lenguaje cambiado a'
  
  lang[BC]='*Broadcast entregado*.'
  
  lang[LEAVECHAT]='*Chat abandonado*.'
  
  lang[GETMEMBERS]='*Miembros aquí*:'
  
  lang[SUDOS]='*Usuarios sudo*'
  
  lang[MD]='*Mensaje entregado*.'
  
  lang[NEWADMIN]='promovido a *administrador*.'
  
fi

if [ $LANG == 'EN' ] || [ $LANG == 'en' ]; then
declare -A lang

  lang[START]='Hi everybody! 
This is a *bot* written in code *shell*
More functions made by @iicc1 and @Jarriz.

*Commands*
 *Users*:
  /start or /help `Start bot and get this message`.
  /info `Get shorter info message about this bot`.
  /getinfo <_by reply_> `Get info user by reply`.
  /calculator `Start a interactive calculator`.
  /cancel `Cancel any currently running interactive chats`.
  /echo <_text_> `The bot will send a echo message (markdown compatible)`.
  /myinfo `The bot will send your info user`.
  /getmembers `The bot will you send the count of members in the chat`.
  /calc <_expr_> `The bot will calculate the expression`.
  /kickme `You will be autokicked from the chat`.
  /ct <_message_> `Send a message to the bot admins`.
  
 *Admin*:
  /leavechat `The bot will leave the group with this command`.
  /broadcast <_text_> `The bot will send a broadcast (markdown compatible)`.
  /kick <_by reply_> `The bot will kick the user by reply (the user can back again)`.
  /ban <_by reply_> `The bot will ban the user by reply (the user cant back again)`.
  /unban <_by reply_> `The bot will unban the user by reply if is banned`.
  /infobot `The bot will reply the information of the bot`.
  /su <_command_> `Run a command in the console sending the reply`.
  /ip `The bot will send the IP Server`.
  /gban <_by reply_> `The user replied will be gbanned`.
  /ungban <_by reply_> `The user replied will be ungbanned`.
  
*Based* in [telegram-bot-bash](http://github.com/topkecleon/telegram-bot-bash)'

  lang[INFO]='This is a bashbot of *Telegram* written entirely in *bash*.
Get the code [here](https://github.com/iicc1/TgBash)'

  lang[USER]='User'
  
  lang[NAME]='Name'
  
  lang[LASTNAME]='Last name'
  
  lang[GBANNED]='globally banned'
  
  lang[UNGBANNED]='globally unbanned'
  
  lang[ID]='ID'

  lang[LANG_NO_AVAILABLE]="The lang \"*${ENTRY[1]}*\" isn't available"
  
  lang[CHANNEL_ID]='*Channel ID*'
  
  lang[IP]='The IP of the server is:'
  
  lang[PRIVATE]='This command *only works* in *private*.'
  
  lang[LANG]='Language changed to'
  
  lang[BC]='*Broadcast delivered*.'
  
  lang[LEAVECHAT]='*Chat leaved*.'
  
  lang[GETMEMBERS]='*Members here*:'
  
  lang[SUDOS]='*Sudo users*'
  
  lang[MD]='*Message delivered*.'
  
  lang[NEWADMIN]='promoted to *admin*.'

fi
