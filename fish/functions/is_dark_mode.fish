# test if the OS is dark mode

function is_dark_mode --description "Test if the OS is dark mode"
    if test (uname -s) = Darwin
        defaults read -g AppleInterfaceStyle &>/dev/null
        return $status
    else
        # TODO: add linux support
        return 1
    end
end
