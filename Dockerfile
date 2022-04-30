FROM alpine:latest
COPY ./requirements.txt /tmp/requirements.txt
VOLUME /output
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
RUN apk update &&\
    apk add --no-cache gcc musl-dev python3 python3-dev py3-pip postgresql-dev graphviz graphviz-dev curl fontconfig
RUN curl -s -O https://moji.or.jp/wp-content/ipafont/IPAexfont/IPAexfont00301.zip
RUN mkdir -p /usr/share/fonts/ipa
RUN unzip IPAexfont00301.zip -d /tmp
RUN cp /tmp/IPAexfont00301/*.ttf /usr/share/fonts/ipa/
RUN fc-cache -fv
RUN pip3 install -r /tmp/requirements.txt
ENTRYPOINT ["eralchemy"]
