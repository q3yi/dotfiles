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

## summary

- `cargo` set mirror of crate.io.

- `fish` setup some environment variables, add two useful function:
    - `proxy` command help to toggle proxy in shell and macOS
    - `p` command jump to git project in predefined project folders, require `fd` and `fzf` to work

- `git` set username and email.

4. `hammerspoon` mainly used to manage window layouts on macOS.

5. `tmux` change prefix key <kbd>Ctrl+b</kbd> to <kbd>Ctrl+z</kbd> and change some other settings.
