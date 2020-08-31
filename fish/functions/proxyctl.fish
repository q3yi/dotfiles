# system proxy only work on macOS

set proxy_interface 'Wi-Fi'
set proxy_listen_addr '127.0.0.1'
set proxy_web_port 1081
set proxy_sock_port 1082
set proxy_bypass_addrs 192.168.0.0/16 10.0.0.0/8 172.16.0.0/12 100.64.0.0/10 localhost '*.local'

function switchSystemProxy -a state
	networksetup -setwebproxystate $proxy_interface $state
	networksetup -setsecurewebproxystate $proxy_interface $state
	networksetup -setsocksfirewallproxystate $proxy_interface $state
end

function setSystemProxy
	networksetup -setproxybypassdomains $proxy_interface $proxy_bypass_addrs
	networksetup -setwebproxy $proxy_interface $proxy_listen_addr $proxy_web_port
	networksetup -setsecurewebproxy $proxy_interface $proxy_listen_addr $proxy_web_port
	networksetup -setsocksfirewallproxy $proxy_interface $proxy_listen_addr $proxy_sock_port

	switchSystemProxy 'on'
end

function displaySystemProxy
	echo "---http  proxy---"
	networksetup -getwebproxy $proxy_interface
	echo "---https proxy---"
	networksetup -getsecurewebproxy $proxy_interface
	echo "---sock5 proxy---"
	networksetup -getsocksfirewallproxy $proxy_interface
end

function setShellProxy
	set -gx http_proxy "http://$proxy_listen_addr:$proxy_web_port"
	set -gx https_proxy "http://$proxy_listen_addr:$proxy_web_port"
	set -gx all_proxy "socks5://$proxy_listen_addr:$proxy_sock_port"
end

function clearShellProxy
	set -gu http_proxy
	set -gu https_proxy
	set -gu all_proxy
end

function displayShellProxy
	echo "shell proxies"
	echo "http:  $http_proxy"
	echo "https: $http_proxy"
	echo "sock5: $all_proxy"
end

function proxyctl -a op env -d "Control system and shell proxy"
	switch "$op"
	case get
		if test "$env" = "system"
			displaySystemProxy
			return
		end
		if test "$env" = "shell"
			displayShellProxy
			return
		end
	case start
		if test "$env" = "system"
			setSystemProxy
			return
		end
		if test "$env" = "shell"
			setShellProxy
			return
		end
		echo "subsystem needed"
	case stop
		if test "$env" = "system"
			switchSystemProxy 'off'
			return
		end
		if test "$env" = "shell"
			clearShellProxy
			return
		end
	case '*'
		echo "only 'get', 'start' or 'stop' allowed"
		return
	end

	echo "environment needed, 'system' or 'shell'"
end

