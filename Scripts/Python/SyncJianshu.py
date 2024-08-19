from os import listdir, mkdir, path
from os.path import isfile, join, isdir
from pathlib import Path
import re
from urllib import request

dir_root = "D:\\Temp\\Jianshu\\user-1025465-1605233232"  # 此处改成文件解压后的路径
anthologies = [anthology for anthology in listdir(dir_root) if isdir(join(dir_root, anthology))]
print(anthologies)

for anthology_dir in anthologies:
    anthology_path = dir_root + "/" + anthology_dir
    article_files = [article_file for article_file in listdir(anthology_path) if isfile(join(anthology_path, article_file))]
    print(article_files)
    
    for file in article_files:
        text = Path(anthology_path + "/" + file).read_text(encoding='utf-8')
        img_urls = re.findall(r"(?:!\[(.*?)\]\((.*?)\))", text)
        for img_url in img_urls:
            if img_url is not None:
                img_name = re.search(r"\d{7}-\S+?\.(png|PNG|jpg|JPG)", img_url[1])
                if not path.exists(anthology_path + "/images"):
                    mkdir(anthology_path + "/images")
                request.urlretrieve(img_url[1], anthology_path + "/images/" + img_name.group())
            pass
        pass
        # 此处可能需要调整，懒得写正则匹配
        text = re.sub(r"http[s]?://upload-images.jianshu.io/upload_", '', text)
        text = re.sub(r"\?imageMogr2/auto-orient/strip%7CimageView2/2/w/\d{3,4}", '', text)
        Path(anthology_path + "/" + file).write_text(text, encoding='utf-8')
    pass
