# Modify prompts in order to show signs when vi normal mode is active in the terminal
PROMPT="${PROMPT}\$(vi_mode_prompt_info)"
RPROMPT="\$(vi_mode_prompt_info)${RPROMPT}"

