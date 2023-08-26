FROM python:3
RUN apt-get update && apt-get install -y \
    libaio1

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY ./requirements.txt .
# Copia de instantclient_12_2
COPY ./instantclient_12_2 /opt/oracle/instantclient_12_2
RUN ln -s /opt/oracle/instantclient_12_2/libclntsh.so.12.1 /opt/oracle/instantclient_12_2/libclntsh.so
RUN ln -s /opt/oracle/instantclient_12_2/libocci.so.12.1 /opt/oracle/instantclient_12_2/libocci.so
RUN sh -c "echo /opt/oracle/instantclient_12_2 > \
    /etc/ld.so.conf.d/oracle-instantclient.conf" \
    ldconfig
ENV LD_LIBRARY_PATH /opt/oracle/instantclient_12_2:$LD_LIBRARY_PATH

RUN pip install --upgrade pip
# RUN python -m venv venv
# RUN . venv/bin/activate

RUN pip install -r requirements.txt
ENV PYTHONUNBUFFERED 1
# ENV PATH /home/user/miniconda3/bin/:$PATH
COPY . .
