# Set the prefix of the main micromamba installation
export MAMBA_ROOT_PREFIX="${HOME}/.local/share/micromamba"

# Access micromamba within the current shell session
eval "$(micromamba shell hook -s zsh)"
