### [From @denvza](https://gist.githubusercontent.com/denvazh/d077bc6d37e900f92250/raw/3fc30f4e7a0e7840dc89527b5bb9b2bd43618204/README.md)

# Scheduled updates for homebrew

This two launchdaemon scripts provide scheduled updates and upgrade for homebrew packages.

It will run in the following way:
* `brew update` every day at 12:10
* `brew upgrade` every day at 12:20

# How to install

Create directory to store logs:

```
$ sudo mkdir -p /var/log/homebrew
```

There are two options for running those scripts.

## For specific user

This will run tasks only when user is logged in.

1. Put both files to `~/Library/LaunchAgents/`
2. Load both plist files using `launchctl load` providing absolute path to the plist file

*EDIT (by @nonissue): I had to chmod the logs folder to 777.*

## For all users

This way it is possible to run updates regardless of any user active login session. This method, however requires admin  privileges, thus run commands below with `sudo`. 

1. Put both files to `/Library/LaunchDaemons/`
2. Fix permissions `chmod 644 /Library/LaunchDaemons/*.plist`
3. Make sure that owner is `root:wheel` by running `chown root:wheel /Library/LaunchDaemons/*.plist`
4. Load both plist files using `launchctl load` providing absolute path to the plist file

### Update by @nonissue

```
sudo mkdir -p /var/log/homebrew
sudo chmod -R 777 /var/log/homebrew
ln -s ~/.dotfiles/macos/brew-scheduler/com.brew.update.plist ~/Library/LaunchAgents
ln -s ~/.dotfiles/macos/brew-scheduler/com.brew.upgrade.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/com.brew.update.plist
launchctl load ~/Library/LaunchAgents/com.brew.upgrade.plist
```