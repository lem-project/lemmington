[![JCS-ELPA](https://raw.githubusercontent.com/jcs-emacs/badges/master/elpa/v/lemmington.svg)](https://jcs-emacs.github.io/jcs-elpa/#/lemmington)

<a href="#"><img align="right" src="./icon.png" width="20%"></a>

# Lemmington

This is a package for RPC integrations with from GNU Emacs to  [Lem](https://github.com/lem-project/lem).

## Installation

#### package.el

This package is available from [JCS-ELPA](https://jcs-emacs.github.io/jcs-elpa/).
Install from this repository then you should be good to go!

#### use-package

If you are using [use-package](https://www.emacswiki.org/emacs/UsePackage),
add the following to your `init.el` file:

```elisp
(use-package lemmington :ensure t)
```

#### straight.el

With [straight.el](https://github.com/radian-software/straight.el):

```elisp
(use-package lemmington
  :straight (lemmington :type git :host github :repo "lem-project/lemmington"))
```

#### Manual installation

Copy all `.el` files in this repository to `~/.emacs.d/lisp` and add the following:

```elisp
(add-to-list 'load-path "/path/to/lemmington/")
```

or

```elisp
(use-package lemmington
  :load-path "/path/to/lemmington")
```

## Usage

To start the server call `lemmington-start-server` and `lemmington-export-functions`, the default port is 55486, every other function is meant to be called from Lem.

To connect to the Emacs server from Lem, call the function `(lem-elisp-mode/rpc:connect-to-server)`, this should enable the RPC calls.

## License

Copyright (C) 2023 Fermin Munoz and contributors

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
