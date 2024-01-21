"""_summary_
    Introductions:
        1. 用于批量重命名文件名
"""
import os

DIRECTORY_PATH = "./"
file_names = os.listdir(DIRECTORY_PATH)
result: list = [n for n in file_names
                if n.find("-") != -1 if len(n.split("-")[0]) < 3]
for n in result:
    length: int = len(n.split("-")[0])
    delta_len = 3 - length
    add_zero: str = "0" * delta_len
    new_name: str = add_zero + n
    os.rename(n, new_name)
    print(f"文件名 {n} 成功被修改为 {new_name}。")
