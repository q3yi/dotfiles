# dotfiles

There are collection of my configuration for some programs.

## stow

I use `stow` to manage all the symbolics:

1. Install config.

```bash
> stow -d . -t ~ -S fish
```

2. Delete a config.

```bash
> stow -d . -t ~ -D fish
```

## configs

1. `cargo` rust build tool, set mirror of crate.io

2. `fish` default shell config, I remove OMF(oh-my-fish) recently, the
   default fish shell is very useful already. There's not need to add
   any third package to change it.

3. `git` set username and email.

4. `hammerspoon` a customed scripts to manange window on mac, but the
   app is more than that.

5. `nvim` I use a lot `nvim` before I switched to `emacs`, and I never
   look back. Backup the config for some terminal environment maybe
   encounter in future.

6. `tmux` session manager used together with `nvim`, so it is rarely
   used in my system now.
