My dot files collection
=======================

I once had my own configs but at some point I switched away to use the pairing setup that my company managed. I've decided it's time to take control of my own tools again and make my lightsaber my own crafted work and not the same blue one that was passed out.

There are lots of things in here copied from other great minds, my sources are sited at the top of the files.

Installation
------------

The install script assumes you have the dotfiles folder in your home directory. May need to edit the paths to make this work on your setup. Running this will attempt to make symlinks in your home directory for all of the files I use.

    cd dotfiles/bin
    ./install.sh

If you only want to use some of the files, then manually symlink them. An example:

    ln -s ~/dotfiles/.vimrc ~/.vimrc

Misc setup files
----------------

In addition to the standard dotfiles I also have some setup files that (sort of) help manage my setup process on both Ubuntu and OSX. These can be found in the `bin/` folder.

The two most important ones being:

    dotfiles/bin/brew-commands.sh
    dotfiles/bin/ubuntu-commands.sh
