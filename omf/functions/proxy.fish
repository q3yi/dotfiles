# proxy function provide helper to config shell or system proxies.

set proxy_interface Wi-Fi
set proxy_listen_addr '127.0.0.1'
set proxy_web_port 7890
set proxy_sock_port 7890
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
    set -gx all_proxy "socks5://$proxy_listen_addr:$proxy_sock_port"
end

function _proxy_clear_shell_env
    set -gu http_proxy
    set -gu https_proxy
    set -gu all_proxy
end

function _proxy_show_shell_env
    echo "\
shell proxies
http:  $http_proxy
https: $http_proxy
sock5: $all_proxy
"
end

function _proxy_usage
    echo "\
Configurate system or shell proxies. System proxy only works on macOS.

Usage:
  proxy get shell
  proxy start shell
  proxy stop shell
  proxy get system
  proxy start system
  proxy stop system
"
end

function proxy -a op env -d "Control system and shell proxy"
    if test "$op" = ""
        _proxy_usage
        return
    end

    switch "$op"
        case get
            if test "$env" = system
                _proxy_show_system_stat
                return
            end
            if test "$env" = shell
                _proxy_show_shell_env
                return
            end
        case start
            if test "$env" = system
                _proxy_set_system
                return
            end
            if test "$env" = shell
                _proxy_set_shell_env
                return
            end
            echo "subsystem needed"
        case stop
            if test "$env" = system
                _proxy_toggle_system off
                return
            end
            if test "$env" = shell
                _proxy_clear_shell_env
                return
            end
        case '*'
            echo "only 'get', 'start' or 'stop' allowed"
            return
    end

    echo "environment needed, 'system' or 'shell'"
end
