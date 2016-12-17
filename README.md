Tg Bash
-
This is a bot of telegram (public to test) based in [Telegram-Bot-Bash](https://github.com/topkecleon/telegram-bot-bash)
You can test the bot in bash just cloning the repository.


| Require  |
| ------------- |
| [redis-server](https://github.com/antirez/redis)  |
| [jq](https://github.com/stedolan/jq)  |
| [tmux](http://github.com/tmux/tmux)  |
| [curl](https://github.com/curl/curl) |

**Clone**
```bash
git clone --recursive https://github.com/iicc1/TgBash
```

**Install dependences**
```bash
cd TgBash
bash install.sh
```

**Use**:
``` bash
cd TgBash
# Open config.sh and set your token
# Open config.sh and set your ID
sudo ./bot.sh tmux # If you want a tmux session, else if not, start without "tmux"
# Done!
```

### [How to install and add more commands (wiki)](https://github.com/iicc1/TgBash/wiki)




