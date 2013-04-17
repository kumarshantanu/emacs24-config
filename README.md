
My Emacs 24 config files for Clojure and Ruby stuff.

## Installation

### First Time Install

1. Create a softlink to the `dot-emacs.d` directory in `~/.emacs.d`

   ```bash
   $ cd emacs24-config
   $ ln -s `pwd`/dot-emacs.d ~/.emacs.d
   ```

2. Start the GUI Emacs app - it will take time to download/install extensions

3. Quit Emacs

4. Create a softlink to the file `dot-emacs.d/username.el` in `~/.emacs.d/${USER}.el`

   ```bash
   $ cd emacs24-config
   $ ln -s `pwd`/dot-emacs.d/username.el ~/.emacs.d/${USER}.el
   ```

5. Start Emacs again to see effect

6. For web development using [swank-js](https://github.com/swank-js/swank-js)
install [Node.js](nodejs.org) first. (Ubuntu folks should get a
[newer version](https://launchpad.net/~chris-lea/+archive/node.js/)
than what `apt-get` gives.)

7. To enable flycheck, you may need Node.js (see #6) as a common dependency
first. Then, install the following (find external linters with `C-c ! ?`):

   * JSHint http://jshint.com/install/ (`sudo npm install -g jshint`)
   * HTML-Tidy https://github.com/w3c/tidy-html5 (Ubuntu: `apt-get install tidy`)
   * CSSLint https://github.com/stubbornella/csslint (`sudo npm install -g csslint`)


### Upgrade

1. Remove all files/folders except `init.el`, `packages.el` and `username.el`
2. Follow the steps isted in *First Time Install*

## Usage

* Press `Super-j` (Cmd+j on Mac, Win+j on PC) to open a project
* Press `Super-i` (Cmd+i on Mac, Win+i on PC) to open Dirtree (file explorer)
* For CSS/JS web development, press `M-x slime-js-jack-in-node` then visit
http://localhost:8009/swank-js/test.html in browser.

