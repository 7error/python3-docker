FROM debian:10
ENV DEBIAN_FRONTEND noninteractive 
RUN \
sed -i "s|deb.debian.org|mirrors.aliyun.com|g" /etc/apt/sources.list && \
sed -i "s|security.debian.org|mirrors.aliyun.com|g" /etc/apt/sources.list && \
apt-get clean && \
apt-get update && \
apt-get -y upgrade && apt-get install git curl python3 python3-distutils python3-dev jq ca-certificates vim libpq-dev build-essential openssl libssl-dev -yq

RUN curl -sSfL -k https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py --force-reinstall

# pip install -r requirements.txt
# pip freeze > requirements.txt
# pip install scrapy -i https://pypi.tuna.tsinghua.edu.cn/simple


RUN mkdir -p ~/.pip/&& touch ~/.pip/pip.conf

RUN \
echo "[global] " > ~/.pip/pip.conf && \
echo "index-url = https://mirrors.aliyun.com/pypi/simple/" >> ~/.pip/pip.conf && \
echo "[install]" >> ~/.pip/pip.conf && \
echo "trusted-host= mirrors.aliyun.com" >> ~/.pip/pip.conf

RUN pip install scrapy requests psycopg2 sqlalchemy numpy selenium beautifulsoup4 pyquery pymysql pymongo redis -i https://mirrors.aliyun.com/pypi/simple/


RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

ENTRYPOINT []