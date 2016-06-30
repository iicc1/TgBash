#!/bin/bash
#*.*encoding=utf-8*.*

# Select your language
# Available languages: ES, EN
LANG='EN' # Reemplace EN to your code of language (if is available)

# If the lang is ES then
if [ $LANG == 'ES' ]; then
declare -A lang

  lang[START]='¡Hola a todos! 
Este es un bot escrito en código *bash*.
Más funciones hechas por @iicc1 y @Jarriz.

*Comandos*
 *Usuarios*:
  /start ó /help _Inicia el bot con este mensaje_.
  /info _Obtiene un mensaje corto acerca de este bot_.
  /getinfo <por respuesta> _Obtiene la información del usuario respondido_.
  /calculator _Comienza una calculadora interactiva_.
  /cancel _Cancela cualquier acción interactiva_.
  /echo <texto> _El bot repetirá el texto ingresado (markdown compatible)_.
  /myinfo _El bot enviará tu información de usuario_.
  /getmembers _El bot enviará la cuenta de miembros en el chat actual_.
  /calc <expr> _El bot calculará cualquier expresión ingresada_.
  /kickme _Serás autoexpulsado del chat actual_.
  /ct <mensaje> _Envia un mensaje a los admins del bot_.
  
 *Administradores*:
  /leavechat _El bot abandonará el chat con este comando_.
  /broadcast <texto> _El bot enviará un broadcast (markdown compatible)_.
  /kick <por respuesta> _El bot expulsará al usuario respondido (el usuario podrá regresar)_.
  /ban <por respuesta> _El bot baneará al usuario respondido (el usuario no podrá regresar)_.
  /unban <por respuesta> _El bot desbaneará al usuario respondido_.
  /infobot _El bot responderá con la información del mismo_.
  /su <comando> _Arranca un comando devolviendo la respuesta_.
  /ip _El bot enviará la IP del servidor_.
  /gban <por respuesta> _EL usuario respondido será globalmente baneado_.
  /ungban <por respuesta> _EL usuario respondido será globalmente desbaneado_.
  
*Basado* en [telegram-bot-bash](http://github.com/topkecleon/telegram-bot-bash)'
  
  lang[INFO]='Este es un bot de *Telegram* escrito completamente en bash.
Obtén el código [aquí](https://github.com/iicc1/TgBash)'

  lang[USER]='Usuario'
  
  lang[NAME]='Nombre'
  
  lang[LASTNAME]='Apellido'
  
  lang[GBANNED]='globalmente baneado'
  
  lang[UNGBANNED]='globalmente desbaneado'
  
  lang[ID]='ID'
  
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

if [ $LANG == 'EN' ]; then
declare -A lang

  lang[START]='Hi everybody! 
This is a *bot* written in code *shell*
More functions made by @iicc1 and @Jarriz.

*Commands*
 *Users*:
  /start or /help _Start bot and get this message_.
  /info _Get shorter info message about this bot_.
  /getinfo <by reply> _Get info user by reply_.
  /calculator _Start a interactive calculator_.
  /cancel _Cancel any currently running interactive chats_.
  /echo <text> _The bot will send a echo message (markdown compatible)_.
  /myinfo _The bot will send your info user_.
  /getmembers _The bot will you send the count of members in the chat_.
  /calc <expr> _The bot will calculate the expression_.
  /kickme _You will be autokicked from the chat_.
  /ct <message> _Send a message to the bot admins_.
  
 *Admin*:
  /leavechat _The bot will leave the group with this command_.
  /broadcast <text> _The bot will send a broadcast (markdown compatible)_.
  /kick <by reply> _The bot will kick the user by reply (the user can back again)_.
  /ban <by reply> _The bot will ban the user by reply (the user cant back again)_.
  /unban <by reply> _The bot will unban the user by reply if is banned_.
  /infobot _The bot will reply the information of the bot_.
  /su <command> _Run a command in the console sending the reply_.
  /ip _The bot will send the IP Server_.
  /gban <by reply> _The user replied will be gbanned_.
  /ungban <by reply> _The user replied will be ungbanned_.
  
*Based* in [telegram-bot-bash](http://github.com/topkecleon/telegram-bot-bash)'

  lang[INFO]='This is a bashbot of *Telegram* written entirely in *bash*.
Get the code [here](https://github.com/iicc1/TgBash)'

  lang[USER]='User'
  
  lang[NAME]='Name'
  
  lang[LASTNAME]='Last name'
  
  lang[GBANNED]='globally banned'
  
  lang[UNGBANNED]='globally unbanned'
  
  lang[ID]='ID'
  
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
