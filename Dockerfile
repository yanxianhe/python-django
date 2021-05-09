FROM python:3.7.10
WORKDIR /usr/src/app
COPY ./mysite /usr/src/app
COPY ./requirements.txt ./
RUN pip install -i https://pypi.doubanio.com/simple/ -r requirements.txt
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]