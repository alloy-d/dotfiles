# WARNING: zoxide would have you eval this script from zoxide.
# This was generated with:
#
#     zoxide init elvish --cmd j | upgrade-scripts-for-0.17 -lambda
#
# to account for the backwards-incompatible changes in Elvish 0.17.
#
# Eventually this file should probably go away.
use builtin
use path

# =============================================================================
#
# Utility functions for zoxide.
#

# cd + custom logic based on the value of _ZO_ECHO.
fn __zoxide_cd {|path|
    builtin:cd $path
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to track previous directory.
var oldpwd = $builtin:pwd
set builtin:before-chdir = [$@builtin:before-chdir {|_| edit:add-var oldpwd $builtin:pwd }]

# Initialize hook to add directories to zoxide.
if (builtin:not (builtin:eq $E:__zoxide_shlvl $E:SHLVL)) {
    set E:__zoxide_shlvl = $E:SHLVL
    set builtin:after-chdir = [$@builtin:after-chdir {|_| zoxide add -- $pwd }]
}

# =============================================================================
#
# When using zoxide with --no-aliases, alias these internal functions as
# desired.
#

# Jump to a directory using only keywords.
fn __zoxide_z {|@rest|
    if (builtin:eq [] $rest) {
        __zoxide_cd ~
    } elif (builtin:eq [-] $rest) {
        __zoxide_cd $oldpwd
    } elif (and ('builtin:==' (builtin:count $rest) 1) (path:is-dir &follow-symlink=$true $rest[0])) {
        __zoxide_cd $rest[0]
    } else {
        var path
        try {
            set path = (zoxide query --exclude $pwd -- $@rest)
        } except {
        } else {
            __zoxide_cd $path
        }
    }
}
edit:add-var __zoxide_z~ $__zoxide_z~

# Jump to a directory using interactive search.
fn __zoxide_zi {|@rest|
    var path
    try {
        set path = (zoxide query -i -- $@rest)
    } except {
    } else {
        __zoxide_cd $path
    }
}
edit:add-var __zoxide_zi~ $__zoxide_zi~

# =============================================================================
#
# Convenient aliases for zoxide. Disable these using --no-aliases.
#

edit:add-var j~ $__zoxide_z~
edit:add-var ji~ $__zoxide_zi~

# Load completions.
fn __zoxide_z_complete {|@rest|
    if (!= (builtin:count $rest) 2) {
        builtin:return
    }
    edit:complete-filename $rest[1] |
        builtin:each {|completion|
            var dir = $completion[stem]
            if (path:is-dir $dir) {
                builtin:put $dir
            }
        }
}
set edit:completion:arg-completer[j] = $__zoxide_z_complete~

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually
# ~/.elvish/rc.elv):
#
#   eval (zoxide init elvish | slurp)
#
# Note: zoxide only supports elvish v0.16.0 and above.
