{
    setopt local_options

    typeset -Ag ZI
    typeset -gx ZI[HOME_DIR]="${XDG_DATA_HOME}/zi"
    typeset -gx ZI[BIN_DIR]="${ZI[HOME_DIR]}/bin"

    [[ ! -d "$ZI[BIN_DIR]" ]] &&
	command git clone https://github.com/z-shell/zi.git "$ZI[BIN_DIR]"

    source "${ZI[BIN_DIR]}/zi.zsh"
}



