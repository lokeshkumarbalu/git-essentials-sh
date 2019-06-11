echo "Bash loaded with .profile settings"

function GetCurrentBranch {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

PS1='\[\033]0;Git Bash\007\]'
PS1="$PS1"'\n$ '
PS1="$PS1"'\[\033[33m\]'
PS1="$PS1"'\w'
PS1="$PS1"'\[\033[1;37m\]'
PS1="$PS1"' >>> '
PS1="$PS1"'\[\033[32m\]'
PS1="$PS1"'[`GetCurrentBranch`]'
PS1="$PS1"'\[\033[1;37m\]'
PS1="$PS1"'\n$ '

