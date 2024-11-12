# zsh-ssh-agent

A Zsh plugin that starts `ssh-agent` automatically if it is not already running.

## Install

Using the [:zap: Zap](https://www.zapzsh.com/) Zsh plugin manager, add the following to
your `.zshrc`

```sh
plug "sdiebolt/zsh-ssh-agent"
```

## Set a maximum lifetime for keys

To set a maximum lifetime when adding identities to `ssh-agent`, add the `lifetime`
style to your `.zshrc` **before the line that installs the plugin**. The lifetime may be
specified according to `sshd_config(5)` (see `TIME FORMATS`). If left unspecified, the
default lifetime is forever.

```
zstyle :plugins:ssh-agent lifetime 4h
```

## Automatically add keys to `ssh-agent`

To automatically add keys to `ssh-agent`, add the following to your `~/.ssh/config`
file:

```
AddKeysToAgent yes
```

## Credits

This plugin is based on the [Oh My Zsh](https://ohmyz.sh/) plugin
[zsh-ssh-agent](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent).
Unfortunately, the Oh My Zsh plugin cannot be installed as a standalone plugin using
[:zap: Zap](https://www.zapzsh.com/).
