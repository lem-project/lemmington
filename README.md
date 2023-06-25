![](https://github.com/Sasanidas/lemmigton/blob/master/icon.png)
# Lemmington

This is a package for RPC integrations with from GNU Emacs to  [Lem](https://github.com/lem-project/lem).

## Installation

For now, add the files to GNU Emacs load-path

```elisp
(add-to-list 'load-path "/path/to/lemmington/")

```


## Usage

To start the server call `lemmington-start-server`, the default port is 55486, every other function is meant to be called from Lem.

It can also be used with https://codeberg.org/sasanidas/eltr so the REPL is in sync with the Emacs behind



