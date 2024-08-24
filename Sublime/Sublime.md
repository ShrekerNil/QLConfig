# Sublime Text 4

## Gists

- 参考Git文件夹中的Gists

## 常用快捷键

| 编号 |              功能               | 快捷键                                                       | 备注                                                         |
| ---- | :-----------------------------: | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    |  命令模式<br/>Command Palette   | Ctrl + Shift + P                                             | 命令提示框                                                   |
| 2    | 文件选择模式<br/>File Switching | Ctrl + P                                                     | 1. 输入@+函数名，可以快速查找到函数<br/>2. 输入#+文本，可以快速进行文件内文本匹配 |
| 3    |  方法选择模式<br/>Goto Symbols  | Ctrl+ R                                                      |                                                              |
| 4    |   多行编辑模式<br/>Multi-Edit   | 1. Ctrl + \<click\><br/>2. Shift + 右键<br/>3. Alt + F3<br/>4. Ctrl+Shift+L | 1. 自由多行编辑<br/>2. 连续多行编辑<br/>3. 选中相同编辑<br/>4. 选中行末尾编辑 |
|      |                                 |                                                              |                                                              |

## 常用插件

| 软件名称            | 用途             | 备注                                                         |
| ------------------- | ---------------- | ------------------------------------------------------------ |
| LSP                 | 编码编辑辅助功能 |                                                              |
| **Package Control** | 插件管理工具     |                                                              |
| **Emmet**           |                  | **使用方法:** `ctrl + alt + enter` ,并且开始输入Emmet风格的HTML, **[Emmet指南](https://scotch.io/tutorials/write-html-crazy-fast-with-emmet-an-interactive-guide)** |
| **CodeFormatter**   | 代码格式化工具   | https://github.com/akalongman/sublimetext-codeformatter      |
| **Sublimerge Pro**  |                  |                                                              |



## 配置

### 配置

```json
{
    "always_prompt_for_file_reload": true,
    "auto_complete": true,
    "auto_complete_commit_on_tab": false,
    "auto_hide_menu": false,
    "auto_hide_tabs": false,
    "block_caret": false,
    "bold_folder_labels": true,
    "caret_extra_bottom": 0,
    "caret_extra_top": 0,
    "caret_extra_width": 1,
    "caret_style": "smooth",
    "color_scheme": "Mariana.sublime-color-scheme",
    "default_encoding": "UTF-8",
    "default_line_ending": "unix",
    "draw_white_space": ["selection"],
    "enable_tab_scrolling": true,
    "fade_fold_buttons": true,
    "file_tab_style": "rounded",
    "fold_buttons": true,
    "hide_new_tab_button": true,
    "hide_tab_scrolling_buttons": true,
    "highlight_line": true,
    "highlight_modified_tabs": true,
    "ignored_packages": ["Vintage"],
    "line_numbers": true,
    "line_padding_bottom": 1,
    "line_padding_top": 1,
    "margin": -15,
    "overlay_scroll_bars": "disabled",
    "reload_file_on_change": true,
    "show_encoding": true,
    "show_indentation": true,
    "show_line_endings": true,
    "show_syntax": true,
    "show_tab_close_buttons": false,
    "tab_size": 2,
    "theme": "Default Dark.sublime-theme",
    "translate_tabs_to_spaces": true,
    "trim_trailing_white_space_on_save": true,
    "word_wrap": true,
    "close_find_after_find_all": false,
    "close_find_after_replace_all": false,
    "font_options": ["gdi","no_bold"],
    /*"font_face": "Microsoft YaHei UI",*/
    /*"font_face": "Microsoft YaHei UI Light",*/
    /*"font_face": "Cascadia Code PL Light",*/
    /*"font_face": "Cascadia Mono PL Light",*/
    /*"font_face": "JetBrains Mono",*/
    /*"font_face": "新宋体",*/
    /*"font_face": "NSimSun",*/
    /*"font_face": "YaHeiMono",*/
    /*"font_face": "星汉等宽 CN",*/
    /*"font_face": "Sarasa Mono SC Extralight",*/
    "font_face": "等距更纱黑体 SC Xlight",
    /*"font_face": "等距更纱黑体 SC Extralight",*/
    /*"font_face": "等距更纱黑体 SC Extralight Italic",*/
    /*"font_face": "等距更纱黑体 SC",*/
    /*"font_face": "等距更纱黑体 SC Xlight",*/
    "font_size": 14,
}
```



## 常见问题

### 关于中文换行

全部中文的情况下，很有可能半行就自动换行了，目前没有找到解决方案