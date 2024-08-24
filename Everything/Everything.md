# Everything

## 常见用法

### 指定文件夹搜索

```
<file-path> <keyword>
```

### 排除文件夹搜索

```
!<file-path> <keyword>
```

### 文件模糊搜索

```
# 既包含keyword1也包含keyword2
<keyword1> <keyword2>

# 包含keyword1或包含keyword2
<keyword1>|<keyword2>
```

### 同时指定关键词和后缀

```
<keyword> *.<ext>
<keyword> *.<ext1>|*.<ext1>
```

### 按照类型搜索

```
file:<keyword>
folder:<keyword>
```

### 按照文件大小搜索

```
<keyword> size:>500mb
<keyword> size:100mb-500mb
```

