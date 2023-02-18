PROMPT='%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
PROMPT+="%(?:%{$fg_bold[magenta]%}❯ :%{$fg_bold[red]%}❯ )"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}on %{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[yellow]%}●"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"
