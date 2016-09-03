Tg Bash
-
This is a bot of telegram (public to test) based in [Telegram-Bot-Bash](https://github.com/topkecleon/telegram-bot-bash)

Using dependences [JQ](https://github.com/stedolan/jq) and [Tmux](http://github.com/tmux/tmux)

You can test the bot in bash just cloning the repository.

| Require  | Autoinstall? |
| ------------- | ------------- |
| redis-bash-cli  | no  |
| jq  | yes  |
| tmux  | yes  |

Installing **redis-bash-cli**...
```bash
git clone https://github.com/caquino/redis-bash db
cd db
sudo make install
```

**Use**:
``` bash
git clone https://github.com/iicc1/TgBash.git
sudo ./bot.sh tmux # If you want a tmux session, else if not, start without "tmux"
# Paste token
# Paste your id
# Done!
```

### [How to install and add more commands (wiki)](https://github.com/iicc1/TgBash/wiki)




