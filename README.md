# 趣刷
[<img src="asset/svg/launch_icon.svg" width="30%" height="30%">](https://fir.im/funrefresh)
<!--- ![趣刷logo](asset/svg/launch_icon.svg) -->
# Dart格式自定义规范：
1. 去除 void new 等关键字。
2. 当方法只有一个返回语句时用=>折叠代码块。
3. 常量统一放到一个文件下。
4. 多个文件引入相同的包时，将引入的包导出到单独的文件下。
5. 字符串统一使用''单引号。
6. 为了增强代码可读性和后续维护，方法声明类型要加上（简单类型要省略，如Widget funX() => Widget）。