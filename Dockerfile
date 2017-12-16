FROM alpine:edge



ENV TESSERACT_GIT_COMMIT eba0ae3b88a46a93e981770caa0b148d65cc4468

##############################
# Install necessary software
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache --virtual .build-deps python3-dev build-base git sudo \
      libmagic leptonica-dev libpng-dev libjpeg tiff-dev zlib-dev \
      autoconf autoconf-archive automake libtool pkgconf gnupg file && \
    cd /tmp/ && \
    git clone https://github.com/tesseract-ocr/tesseract.git tesseract-ocr && \
    cd tesseract-ocr && \
    git checkout $TESSERACT_GIT_COMMIT && \
    ./autogen.sh && \
    ./configure --prefix=/usr/ --datadir=/usr/share/tessdata/ && \
    make && \
    make install && \
    cd /usr/share/tessdata/ && \
    mv tessdata/* ./ && \
    rm -rf tessdata && \
    wget https://github.com/tesseract-ocr/tessdata_fast/raw/master/eng.traineddata && \
    wget https://github.com/tesseract-ocr/tessdata_fast/raw/master/osd.traineddata && \
    rm -rf /tmp/tesseract-ocr/ && \
    cd /usr/src/paperless && \
    apk del .build-deps && \
    apk add --no-cache python3 sudo imagemagick ghostscript gnupg bash rsync sqlite \
      poppler-utils unpaper libmagic leptonica libpng libjpeg tiff zlib shadow




##############################
# Mount volumes
VOLUME ["/exchange"]

ENTRYPOINT ["tesseract"]
CMD ["--help"]


