# python-django


#### 制作docker 镜像
> 需要一个安装docker 机器可以上互联网,也可借助registry.hub.docker.com构建

* 创建一个空白的文件夹,文件创建 Dockerfile文件、把项目代码、以及requirements.txt 放在当前目录

~~~~~
~/dockerfile>ls

Dockerfile  mysite  requirements.txt

~~~~~

* 确定python 版本

* Dockerfile

~~~~~

#### 指定项目使用python 版本
FROM python:3.7.10
#### 镜像来源 https://registry.hub.docker.com/_/python
LABEL maintainer "yanjing <xue_jing_yan@163.com>"
#### 创建项目使用目
RUN mkdir -p /var/upload_file && mkdir -p /var/ftp/
#### 指定工作目录
WORKDIR /usr/src/app
#### 将项目拷贝到具体目录下
COPY ./mysite /usr/src/app
#### 将项目requirements.txt拷贝到具体目录下
COPY ./requirements.txt ./
#### 安装项目pip requirements.txt
RUN pip install -i https://pypi.doubanio.com/simple/ -r requirements.txt
#### 指定容器内部端口
EXPOSE 8000
#### 启动django 项目
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
~~~~~

* 进入到Dockerfile 文件所在目录构建镜像,镜像大小、以及构建时间。取决于安装项目pip大小
* 构建镜像 docker build -t <app_name:value> .
~~~~~
docker build -t my_python_django:v1.0.0 .
~~~~~

* 构建完成后直接运行 --restart=always 开机自动启动
* 如需要保存的文件目录
~~~~~
docker run --restart=always --name my_app -p 8080:8000 -v /var/upload_file/:/var/upload_file/ -v /var/ftp/:/var/ftp/ -d my_python_django:v1.0.0
~~~~~