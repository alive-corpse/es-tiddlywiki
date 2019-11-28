### Tiddly wiki 5 with node.js and TiddlyMap plugin

FROM alpine:latest
MAINTAINER Evgeniy Shumilov <evgeniy.shumilov@gmail.com>

ENV wikiname MyTiddlyWiki
ENV UNAME tiddlywiki
ENV PS1='\\[\\e[1;32m\\]\u\[\e[1;33m\]@\[\e[1;32m\]\h \[\e[1;33m\][\[\e[1;36m\]$([ $? -eq 0 ] && echo "\\[\\e[1;32m\\]$?" || echo "\\[\\e[1;31m\\]$?")\[\e[1;33m\]]\[\e[0;33m\]:\[\e[1;33m\][\[\e[1;34m\]\t\[\e[1;33m\]]\[\e[0;33m\]:\[\e[1;33m\][\[\e[1;36m\]\w\[\e[1;33m\]\\[\e[1;33m\]]\[\e[1;31m\]\\[\\e[1;32m\\]\$ \[\e[0m\]'
ENV CUID "$CUID"
ENV CGID "$CGID"
ENV HOME /tw

ADD .env /etc/.env
ADD /bin/tw /usr/local/bin/tw
ADD /bin/createuser /usr/local/bin/createuser

RUN mkdir -p /tw/data /nm && /usr/local/bin/createuser ${UNAME} && chown -R ${UNAME}:${UNAME} /tw /nm
RUN apk add --no-cache npm
RUN npm install -g tiddlywiki 
RUN cd /usr/lib/node_modules/tiddlywiki/plugins && cd /tmp/ && \
    echo 'TW5-HotZone TW5-TiddlyMap TW5-TopStoryView TW5-Vis.js' | tr ' ' '\n' | awk '{ print "wget https://github.com/felixhayashi/"$1"/archive/master.zip -O "$1".zip\nunzip "$1".zip \""$1"-master/dist/*\"\ncp -R "$1"-master/dist/* /usr/lib/node_modules/tiddlywiki/plugins/\nrm -rf "$1"*" }' | sh
VOLUME /tw/data
RUN chown -R ${UNAME}:${UNAME} /tw
EXPOSE 8080
USER ${UNAME}
WORKDIR /tw
RUN tiddlywiki /tw/data --init server && sed -i 's/^[ ]*"plugins".*/    "plugins": \[\n        "felixhayashi\/tiddlymap",\n        "felixhayashi\/vis",\n        "felixhayashi\/hotzone",\n        "felixhayashi\/topstoryview",/' /tw/data/tiddlywiki.info && \
    mv /tw/data/tiddlywiki.info /tw/tiddlywiki.info_origin

ENTRYPOINT /usr/local/bin/tw

