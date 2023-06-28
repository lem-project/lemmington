![](https://github.com/Sasanidas/lemmigton/blob/master/icon.png)
# Lemmington

This is a package for RPC integrations with from GNU Emacs to  [Lem](https://github.com/lem-project/lem).

## Installation

For now, add the files to GNU Emacs load-path

```elisp
(add-to-list 'load-path "/path/to/lemmington/")

```


## Usage

To start the server call `lemmington-start-server` and `lemmington-export-functions`, the default port is 55486, every other function is meant to be called from Lem.


To connect to the Emacs server from Lem, call the function `(lem-elisp-mode/rpc:connect-to-server)`, this should enable the RPC calls.
