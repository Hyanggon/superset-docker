ARG PYTHON_VERSION=3.10
FROM python:$PYTHON_VERSION

# 환경 변수 설정
ENV FLASK_APP=superset
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV PYTHONPATH=/etc/superset:/home/superset
ENV SUPERSET_HOME=/var/lib/superset

# 파일 시스템 구성
VOLUME /etc/superset
VOLUME /home/superset
VOLUME /var/lib/superset

# Superset 사용자 생성 및 의존성 설치
WORKDIR /home/superset
RUN groupadd supergroup && \
    useradd -U -G supergroup superset && \
    mkdir -p $SUPERSET_HOME && \
    mkdir -p /etc/superset && \
    chown -R superset:superset $SUPERSET_HOME && \
    chown -R superset:superset /home/superset && \
    chown -R superset:superset /etc/superset && \
    apt-get update && \
    apt-get install -y \
    build-essential \
    vim \
    curl \
    libecpg-dev \
    libffi-dev \
    libpq-dev \
    libssl-dev && \
    apt-get clean && \
    pip install -U pip

# 필수 라이브러리 설치
RUN pip install numpy pandas psycopg2-binary apache-superset pillow flask-cors pyarrow

# Superset 실행 설정
EXPOSE 8080
USER superset
CMD ["superset", "run", "-h", "0.0.0.0", "-p", "8088", "--with-threads"]