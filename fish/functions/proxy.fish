# proxy function provide helper to config shell or system proxies.

set proxy_interface Wi-Fi
set proxy_listen_addr $WSL_HOST_IP
set -q WSL_HOST_IP || set proxy_listen_addr '127.0.0.1'
set proxy_web_port 7890
set proxy_sock_port 7891
set proxy_bypass_addrs 192.168.0.0/16 10.0.0.0/8 172.16.0.0/12 127.0.0.1 localhost '*.local' timestamp.apple.com

function _proxy_toggle_system -a state
    networksetup -setwebproxystate $proxy_interface $state
    networksetup -setsecurewebproxystate $proxy_interface $state
    networksetup -setsocksfirewallproxystate $proxy_interface $state
end

function _proxy_set_system
    networksetup -setproxybypassdomains $proxy_interface $proxy_bypass_addrs
    networksetup -setwebproxy $proxy_interface $proxy_listen_addr $proxy_web_port
    networksetup -setsecurewebproxy $proxy_interface $proxy_listen_addr $proxy_web_port
    networksetup -setsocksfirewallproxy $proxy_interface $proxy_listen_addr $proxy_sock_port

    _proxy_toggle_system on
end

function _proxy_show_system_stat
    echo "---http  proxy---"
    networksetup -getwebproxy $proxy_interface
    echo "---https proxy---"
    networksetup -getsecurewebproxy $proxy_interface
    echo "---sock5 proxy---"
    networksetup -getsocksfirewallproxy $proxy_interface
end

function _proxy_set_shell_env
    set -gx http_proxy "http://$proxy_listen_addr:$proxy_web_port"
    set -gx https_proxy "http://$proxy_listen_addr:$proxy_web_port"
    # set -gx all_proxy "socks5://$proxy_listen_addr:$proxy_sock_port"
    #set -gx no_proxy (echo $proxy_bypass_addrs | sed -e 's/ /,/g')
    set -gx no_proxy (string replace -a ' ' ',' "$proxy_bypass_addrs")
end

function _proxy_clear_shell_env
    set -gu http_proxy
    set -gu https_proxy
    set -gu all_proxy
    set -gu no_proxy
end

function _proxy_show_shell_env
    echo "\
shell proxies
http:   $http_proxy
https:  $http_proxy
sock5:  $all_proxy
bypass: $no_proxy
"
end

function _proxy_usage
    echo "\
Configurate system or shell proxies. System proxy only works on macOS.

Usage:
  proxy shell        # Show shell proxy status
  proxy shell on     # Turn on proxy in shell
  proxy shell off    # Turn off proxy in shell
  proxy system       # Show system proxy status
  proxy system on    # Turn on system proxy
  proxy system off   # Turn off system proxy
"
end

function proxy -a env op -d "Control system and shell proxy"
    if test "$env" = ""
        _proxy_usage
        return
    end

    switch "$env"
        case shell
            if test "$op" = on
                _proxy_set_shell_env
            else if test "$op" = off
                _proxy_clear_shell_env
            else
                _proxy_show_shell_env
            end
        case system
            if test "$op" = on
                _proxy_set_system
            else if test "$op" = off
                _proxy_toggle_system off
            else
                _proxy_show_system_stat
            end
        case '*'
            echo "only empty, 'on' or 'off' allowed"
            return
    end
end
