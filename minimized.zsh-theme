_collapsed_wd() {
  echo $(pwd | perl -pe '
   BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
   }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
')
}

PROMPT_SYMBOL="~>"

PROMPT='%{$fg_bold[white]%}$FG[069]$(_collapsed_wd)%{$reset_color%} \
$(git_prompt_info)\
%{$fg[015]%}$PROMPT_SYMBOL '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%} %{$FG[203]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=""
