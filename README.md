
# Hash-Files

Small library get the hash value of a file or files in a directory.
The hash values will be output in a new buffer named `*hashes*`

# Installation

Clone this repo and add this file in your .emacs.d directory.
Add the following line to your `init.el` file.

```elisp
(require 'hash-files)
```

# Usage

To get the hash of a file or all the file in a directory :

SHA1: `M-x hash-sha1`

SHA256: `M-x hash-sha256`

MD5: `M-x hash-md5`

Also you can bind `dired-do-hash-<hash-type>` to a key to use it in dired-mode.

# LICENSE

See LICENSE file