git clone --depth 1 https://github.com/prasanthrangan/hyprdots

尝试 polybar


1. check 软件安装情况
2. 链接配置文件
3. 执行shell用 `sh file.sh` 才能运行
4. 在链接的配置文件中查看是否由用到函数 _replaceLineInFile 或 _replaceInFile 。
5. waybar 部分乱码，修改awesome font
6. home-manager 配置gtk主题
7. 优化dotfiles中的shell程序

1. ok
2. ok
3. ans: shell的前排聲明方式應該為 `#!/usr/bin/env bash`
5. ok
6. ok


# i3 

https://github.com/maximilionus/dotfiles-i3


# hyprland

https://github.com/prasanthrangan/hyprdots


# polybar

https://github.com/bryant-the-coder/dotfiles
https://github.com/bibjaw99/workstation


# docker
1. chatgpt-hk
2. v2raya 【仅记录】
3. https://github.com/louislam/dockge 【测试】
4. nginx 【学习】



```shell

# 函数名称: _replaceInFile
# 参数:
#   $1: 起始字符串
#   $2: 结束字符串
#   $3: 替换的新字符串
#   $4: 目标文件路径
#
# 说明:
#   该函数用于在指定文件中查找并替换起始字符串和结束字符串之间的文本。
#   如果找到起始字符串和结束字符串，将删除它们之间的文本，并用新字符串替代。
#   输出相应的错误信息，如未找到起始/结束字符串、目标文件不存在等。
#
# 用法示例:
#   _replaceInFile "START_MARKER" "END_MARKER" "New Content" "/path/to/file.txt"
#
_replaceInFile() {

    # 设置函数参数
    start_string=$1
    end_string=$2
    new_string="$3"
    file_path="$4"

    # 计数器
    start_line_counter=0
    end_line_counter=0
    start_found=0
    end_found=0

    if [ -f $file_path ] ;then

        # 检测起始字符串
        while read -r line
        do
            ((start_line_counter++))
            if [[ $line = *$start_string* ]]; then
                start_found=$start_line_counter
                break
            fi 
        done < "$file_path"

        # 检测结束字符串
        while read -r line
        do
            ((end_line_counter++))
            if [[ $line = *$end_string* ]]; then
                end_found=$end_line_counter
                break
            fi 
        done < "$file_path"

        # 检查分隔符是否存在
        if [[ "$start_found" == "0" ]] ;then
            echo "ERROR: 未找到起始分隔符。"
            sleep 2
        fi
        if [[ "$end_found" == "0" ]] ;then
            echo "ERROR: 未找到结束分隔符。"
            sleep 2
        fi

        # 替换分隔符之间的文本
        if [[ ! "$start_found" == "0" ]] && [[ ! "$end_found" == "0" ]] && [ "$start_found" -le "$end_found" ] ;then
            # 删除旧行
            ((start_found++))

            if [ ! "$start_found" == "$end_found" ] ;then    
                ((end_found--))
                sed -i "$start_found,$end_found d" $file_path
            fi
            # 添加新行
            sed -i "$start_found i $new_string" $file_path
        else
            echo "ERROR: 分隔符语法错误。"
            sleep 2
        fi
    else
        echo "ERROR: 未找到目标文件。"
        sleep 2
    fi
}


# 函数名称: _replaceLineInFile
# 参数:
#   $1: 要查找的字符串
#   $2: 替换的新字符串
#   $3: 目标文件路径
#
# 说明:
#   该函数用于在指定文件中查找包含指定字符串的整行，并用新字符串替换该行。
#   如果找到目标字符串，将删除包含它的整行，并用新字符串插入该位置。
#   输出相应的错误信息，如未找到目标字符串、目标文件不存在等。
#
# 用法示例:
#   _replaceLineInFile "TargetString" "New Content" "/path/to/file.txt"
#
_replaceLineInFile() {
   # 设置函数参数
    find_string="$1"
    new_string="$2"
    file_path=$3

    # 计数器
    find_line_counter=0
    line_found=0

    if [ -f $file_path ] ;then

        # 检测行
        while read -r line
        do
            ((find_line_counter++))
            if [[ $line = *$find_string* ]]; then
                line_found=$find_line_counter
                break
            fi 
        done < "$file_path"

        if [[ ! "$line_found" == "0" ]] ;then
            
            # 删除旧行
            sed -i "$line_found d" $file_path

            # 添加新行
            sed -i "$line_found i $new_string" $file_path            

        else
            echo "ERROR: 未找到目标行。"
            sleep 2
        fi   

    else
        echo "ERROR: 未找到目标文件。"
        sleep 2
    fi
}


```