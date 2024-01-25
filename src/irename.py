"""_summary_

    Introductions:
        1. 用于批量重命名文件名
"""
import os

DIRECTORY_PATH = "./"
file_names = os.listdir(DIRECTORY_PATH)
# 通过特征查找文件
# 如果文件名中，从第一个字符到第一个 '-' 字符之间的字符串长度小于 3，则将其保留到一个新的列表中
result: list = [n for n in file_names
                if n.find("-") != -1 if len(n.split("-")[0]) < 3]
# 遍历列表
if result:
    for n in result:
        length: int = len(n.split("-")[0])
        delta_len = 3 - length
        # 需要部几个零到文件名首位
        add_zero: str = "0" * delta_len
        new_name: str = add_zero + n
        os.rename(n, new_name)
        print(f"文件名 {n} 成功被修改为 {new_name}。")
