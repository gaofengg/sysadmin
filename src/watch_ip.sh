#!/usr/bin/env bash

# 监视 /etc/hosts 文件里的绑定 （绑定规则：ip hostname-host）
# 查看 /etc/hosts 文件是否存在？ 如果没有就创建。
host_file="/home/gaofengwub01/WorkSpace/sysadmin/hosts"
if [ ! -f $host_file ]; then
    touch "$host_file"
fi

# 主机名
host_name="gaojing-host"

# 查看本机的ip地址
ip_realtime=$(ip addr show | grep eth0 | grep inet | awk '{split($2, arr, "/"); print arr[1]}')
# 替换到hosts文件的内容 (ip hostname)
new_content="$ip_realtime $host_name"
# 查看 /etc/hosts 文件中包含 hostname-host 内容的行是否存在？
ip_in_conf=$(awk -v hn="$host_name" '$0 ~ "\\s*"hn"\\s*$" {print $1}' $host_file)
# 本机ip在hosts文件中的行号
line_num=$(awk -v hn="$host_name" '$0 ~ "\\s*"hn"\\s*$" {print NR}' $host_file)

if [ -n "$ip_in_conf" ]; then
    if [ ! "$ip_in_conf" == "$ip_realtime" ]; then
        # 如果两个IP 不相等，则用 ip_realtime 替换
        awk -i inplace -v ln="$line_num" -v nl="$new_content" 'NR==ln {$0=nl} {print}' $host_file
        echo "配置文件中的IP：$ip_in_conf 替换为 $ip_realtime"
    else
        echo "无需修改hosts文件配置"
    fi
else
    echo -e "$ip_realtime $host_name" >>$host_file
    echo "向 hosts 文件中添加 $ip_realtime $host_name"
fi
