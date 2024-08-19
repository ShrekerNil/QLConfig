# @Author: Shreker.Nil
# @Date:   2022-12-04 22:54:37
# @Last Modified by:   Shreker.Nil
# @Last Modified time: 2024-03-04 01:56:30

#echo 用法：
#　　\33[0m 关闭所有属性
#　　\33[1m 设置高亮度
#　　\33[4m 下划线
#　　\33[5m 闪烁
#　　\33[7m 反显
#　　\33[8m 消隐
#　　\33[30m — \33[37m 设置前景色   --30:黑色 31:红色 32:绿色 333:黄色 34:蓝色 35:紫色 36:深绿色 37:白色
#　　\33[40m — \33[47m 设置背景色   --40:黑色  41:红色 42:绿色 43:黄色 44:蓝色 45:紫色 46:深绿色 47:白色
#　　\33[nA 光标上移n行
#　　\33[nB 光标下移n行
#　　\33[nC 光标右移n行
#　　\33[nD 光标左移n行
#　　\33[y;xH设置光标位置
#　　\33[2J 清屏
#　　\33[K 清除从光标到行尾的内容
#　　\33[s 保存光标位置
#　　\33[u 恢复光标位置
#　　\33[?25l 隐藏光标
#　　\33[?25h 显示光标

# 颜色代码标识 \003 可以替换为 \E
# 多个 ANSI 控制码可同时使用,用分号(;)作为分隔符, 红底绿字闪烁:echo -e "\E[32;41;05mtest\E[0m"

function new_line() {
    echo -e "\n"
}

echo "默认:黑色背景色(40),白色前景色(37),即:黑底白字"
echo
background_color=$"
字体背景颜色范围:40-47\n
40:黑底 41:红底 42:绿底 43:黄底 44:蓝底 45:紫底 46:天蓝底 47:白底\n
示例代码如下:"
echo -e $background_color
echo -e "\033[40;37m   1、黑  底(40)    白字(37) \033[0m"
echo "      \033[40;37m   1、黑  底(40)    白字(37) \033[0m"
new_line
echo -e "\033[41;37m   2、红  底(41)    白字(37) \033[0m"
echo "      \033[41;37m   2、红  底(41)    白字(37) \033[0m"
new_line
echo -e "\033[42;37m   3、绿  底(42)    白字(37) \033[0m"
echo "      \033[42;37m   3、绿  底(42)    白字(37) \033[0m"
new_line
echo -e "\033[43;37m   4、黄  底(43)    白字(37) \033[0m"
echo "      \033[43;37m   4、黄  底(43)    白字(37) \033[0m"
new_line
echo -e "\033[44;37m   5、蓝  底(44)    白字(37) \033[0m"
echo "      \033[44;37m   5、蓝  底(44)    白字(37) \033[0m"
new_line
echo -e "\033[45;37m   6、紫  底(45)    白字(37) \033[0m"
echo "      \033[45;37m   6、紫  底(45)    白字(37) \033[0m"
new_line
echo -e "\033[46;37m   7、天蓝底(46)    白字(37) \033[0m"
echo "      \033[46;37m   7、天蓝底(46)    白字(37) \033[0m"
new_line
echo -e "\033[47;30m   8、白  底(47)    黑字(37) \033[0m"
echo "      \033[47;30m   8、白  底(47)    黑字(37) \033[0m"

echo
foreground_color=$"字体前景颜色范围:30-37\n
30:黑字 31:红字 32:绿字 33:黄字 34:蓝字 35:紫字 36:天蓝字 37:白字\n
示例代码如下:"
echo -e $foreground_color
echo -e "\033[47;30m   1、白底   黑  字(30) \033[0m"
new_line
echo -e "\033[31m   2、黑底   红  字(31) \033[0m"
new_line
echo -e "\033[32m   3、黑底   绿  字(32) \033[0m"
new_line
echo -e "\033[33m   4、黑底   黄  字(33) \033[0m"
new_line
echo -e "\033[34m   5、黑底   蓝  字(34) \033[0m"
new_line
echo -e "\033[35m   6、黑底   紫  字(35) \033[0m"
new_line
echo -e "\033[36m   7、黑底   天蓝字(36) \033[0m"
new_line
echo -e "\033[37m   8、黑底   白  字(37) \033[0m"
new_line

read -p "PRESSING ENTER TO EXIT ... "
