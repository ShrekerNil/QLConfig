# IdeaConfig

## 我的配置

### 忽略显示/隐藏.idea/iml

通过设置忽略文件夹达到隐藏的目的：

- 打开IDEA的设置：`File  →  Settings`
- 进入 `Editor  →  File Types`
- 在右侧的"Ignore files and folders"输入框中添加 `.idea`，然后点击"OK"

### 格式化注释缩进

> 默认情况下，单行注释会在第一列生成，按照如下配置即可按照格式化缩进进行注释格式化缩进

File → Settings → Editor → Code Style → Java → Code Generation：

去掉 **Line comment at first column** 前的对勾，并选中 **Add a space at comment start**

### 序列化ID警告

Setting → Editor → Inspections → Serialization issues

√ Serializable class without 'serialVersionUID：勾选该选项

### 全局禁用拼写检查

默认情况下Idea会开启拼写检查，有些地方常常是不会用拼写检查，否则会造成变量冗长，禁用最好：

Setting → Editor → Inspections：

1. profiles 选择 Default，而非 Project Default
2. 下方搜索框中键入：spell
3. 找到 Proofreading → Typo，去掉勾选即可

### 查找匹配：FileMask

2020.3版本的Idea全文搜索没有mask配置，即没有按照后缀筛选的选项

```
C:\Users\<account-name>\.IntelliJIdea\config\options\find.xml
```

手动添加

```xml
<application>
    <component name="FindSettings">
        <option name="customScope" value="All Places" />
        <option name="defaultScopeName" value="All Places" />
        <option name="SEARCH_SCOPE" value="All Places" />
        <option name="FILE_MASK" value="*.java" />
        <mask>*.css</mask>
        <mask>*.html</mask>
        <mask>*.java</mask>
        <mask>*.js</mask>
        <mask>*.json</mask>
        <mask>*.jsp</mask>
        <mask>*.md</mask>
        <mask>*.properties</mask>
        <mask>*.vue</mask>
        <mask>*.xml</mask>
        <mask>*.yml</mask>
    </component>
</application>
```

## 代码模板

> 1. 实时代码模板：Setting → Editor → Live Templates
>    - 可修改
> 2. 后缀模板：Setting → Editor → General → Postfix Completion
>    - 不可修改

## 相关配置文章

1. [Share IDE settings](https://www.jetbrains.com/help/idea/sharing-your-ide-settings.html)
2. [IntelliJ IDEA--配置导入导出](https://blog.csdn.net/yanbin0830/article/details/89469568)
3. [idea从入门到精通教程](https://blog.csdn.net/qq_40182873/article/details/86083291)
4. [jetbrains2020系列产品配置文件变动说明(IDEA WebStorm PhpStorm)](https://blog.csdn.net/qq_43413788/article/details/105696414)：给出了 windows 的路径变化
5. [IDEA 配置文件位置](https://www.cnblogs.com/6b7b5fc3/p/12982389.html)：给出了 win, mac, linux 的路径变化
6. [Configuration directory](https://www.jetbrains.com/help/idea/2020.1/tuning-the-ide.html#config-directory)：官网文档
7. [Advanced configuration](https://www.jetbrains.com/help/idea/2020.1/tuning-the-ide.html)：关于 IDE 的一些调优

## 常用插件

1. Alibaba Java Coding Guidelines
2. Codota
3. jclasslib Bytecode Viewer
4. lombok
5. MyBatisX
6. PlantUML integration
7. Maven Helper
8. Vue.js
9. JRebel

当开始开发web项目的时候，需要频繁的修改web页面，此时如果频繁的重启变得很麻烦，因此，可以在idea中集成JRebel插件，改动代码之后不需要重新启动应用程序

1、安装JRebel

（1）在IDEA中一次点击 File → Settings → Plugins → Brows Repositories
​（2）在搜索框中输入JRebel进行搜索
​（3）找到JRebel for intellij
​（4）install
​（5）安装好之后需要restart IDEA

2、激活JRebel

JRebel并非是免费的插件，需要激活之后才可以使用

（1）生成一个GUID：https://www.guidgen.com/

（2）根据反向代理服务器地址拼接激活地址： https://jrebel.qekang.com/{GUID}

（3）打开JRebel激活面板，选择Connect to online licensing service.

（4）点击work offline

## 快捷键

| 类别     | 功能                           | 自定义快捷键      | 默认快捷键       |
| -------- | ------------------------------ | ----------------- | ---------------- |
| 搜索替换 | 全项目搜索                     | Ctrl + U          | Shift + Shift    |
|          | 全局文件中搜索                 | Ctrl + H          |                  |
|          | 全局文件中替换                 | Alt + H           |                  |
|          | 当前文件中搜索                 | Ctrl + F          |                  |
|          | 当前文件中替换                 | Alt + F           |                  |
|          | 搜索类                         |                   | Ctrl + Shift + T |
|          | 搜索文件                       |                   | Ctrl + Shift + R |
|          | 显示类方法列表                 |                   | Ctrl + O         |
|          | 查找接口实现类                 |                   | Ctrl + T         |
| 代码追踪 | 代码追踪：向前                 | →                 |                  |
|          | 代码追踪：向后                 | ←                 |                  |
| 代码生成 | Domain生成代码                 | Alt + Insert      |                  |
|          | for循环代码生成                | fori              |                  |
|          | 代码块包围                     | Ctrl + Alt + T    |                  |
| 焦点切换 | 焦点切换到 Project View        |                   | Alt + 1          |
|          | 焦点切换到 Editor              |                   | Esc              |
| 其他技能 | 方法参数提示                   |                   | Ctrl + P         |
|          | 代码补全                       | Alt + /           |                  |
|          | 文件夹刷新(Reload From Disk)   | Alt + F5          |                  |
|          | 项目刷新(Reload All From Disk) | Ctrl + Shift + F5 |                  |



# 绿化

## V2023.3.7

> https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzA4MjU4MTg2Ng==&action=getalbum&album_id=3421643864929239051
>
> JetBrains2023.zip文件太大也没有用，直接删除了，保留了其中的绿化文件：IdeaGreenize/{IdeaConfig.7z，IdeaConfig.exe}

1. 正常官方下载安装绿色版，安装完成后打开Idea，选择试用，然后关闭Idea
2. 处理配置文件
   1. 解压**IdeaConfig.7z**文件为目录：**IdeaConfig**，将IdeaConfig移动到一个比较安全的位置，如`D:/Documents/IdeaConfig`
   2. 或者直接运行IdeaConfig.exe，解压之后就会直接解压到`D:/Documents/IdeaConfig`
3. 查看配置的存放位置/可做可不做，主要是为了观察安装所做的动作
   - 打开idea，菜单 → help → Change Max Memory ...
4. 运行其中的**安装.bat**，等待直到弹出**success**的提示
5. 注册：
   - 打开idea，菜单 → help → Register
   - 输入校验码，具体可测试校验码是否可以修改文字

## V2020.3.4

1. 创建项目
2. 进入设置
3. 从磁盘加载crack的jar
4. 重启

## V2018.3.6

### Jar

JetbrainsIdesCrack-4.2.jar: 测试版本：2018.3.6
链接:https://pan.baidu.com/s/1qxZAYxn1uOo-y1pz5xD16Q 密码:aikf

### Code

```
ThisCrackLicenseId-{
"licenseId":"ThisCrackLicenseId",
"licenseeName":"ShrekerNil",
"assigneeName":"",
"assigneeEmail":"idea@sina.com",
"licenseRestriction":"For This Crack, Only Test! Please support genuine!!!",
"checkConcurrentUse":false,
"products":[
{"code":"II","paidUpTo":"2099-12-31"},
{"code":"DM","paidUpTo":"2099-12-31"},
{"code":"AC","paidUpTo":"2099-12-31"},
{"code":"RS0","paidUpTo":"2099-12-31"},
{"code":"WS","paidUpTo":"2099-12-31"},
{"code":"DPN","paidUpTo":"2099-12-31"},
{"code":"RC","paidUpTo":"2099-12-31"},
{"code":"PS","paidUpTo":"2099-12-31"},
{"code":"DC","paidUpTo":"2099-12-31"},
{"code":"RM","paidUpTo":"2099-12-31"},
{"code":"CL","paidUpTo":"2099-12-31"},
{"code":"PC","paidUpTo":"2099-12-31"}
],
"hash":"2911276/0",
"gracePeriodDays":7,
"autoProlongated":false}
```



# 附表

## JavaDoc标签及其含义

| 标签                           | 含义                                                         |
| ------------------------------ | ------------------------------------------------------------ |
| `@author`                      | 标识类或接口的作者                                           |
| `@version`                     | 提供类或接口的版本信息                                       |
| `@since`                       | 标识自哪个版本起该类或方法可用                               |
| `@param`                       | 描述方法的参数                                               |
| `@return`                      | 描述方法的返回值                                             |
| `@throws`                      | 描述方法可能抛出的异常                                       |
| `@see`                         | 提供一个链接到其他类、方法或标签的参考                       |
| `@exception`                   | 与 `@throws` 相同，描述方法可能抛出的异常                    |
| `@deprecated`                  | 标记已弃用的方法或类，建议使用新的替代方法                   |
| `@serial`                      | 用于描述可序列化的类的序列化形式                             |
| `@serialField`                 | 用于描述 `ObjectStreamField` 组件的序列化字段                |
| `@serialData`                  | 描述通过 `writeObject()` 和 `writeExternal()` 方法写入的数据 |
| `@docRoot`                     | 指向生成文档的根目录的路径                                   |
| `@code`                        | 用于在文档中显示代码样式的文本                               |
| `@literal`                     | 用于在文档中显示字面量文本，防止文本被解释为 HTML 标签或 Javadoc 标签 |
| `{@value <contant>}`           | 用于显示枚举常量的值                                         |
| `{@link <package>#<class>...}` | 用于创建指向外部资源的超链接                                 |

此外，还有一些特殊的HTML标记可以在Javadoc注释中使用，例如`<u>`（下划线）、`<i>`（斜体）等，以增强文档的可读性

需要注意的是，Javadoc工具只处理公共（public）和受保护（protected）成员的注释，而忽略私有（private）和包内（默认）成员的注释每个标签必须单独开始一行，或者放在带有星号的行之前
