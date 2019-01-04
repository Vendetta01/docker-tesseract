FROM alpine:edge


##############################
# Environment variables
ENV TESSERACT_GIT_COMMIT 51316994ccae0b48692d547030f26c0969308214
# eba0ae3b88a46a93e981770caa0b148d65cc4468


# Use best or fast language data
ENV TESSDATA_TRAINEDDATA tessdata_best
#ENV TESSDATA_TRAINEDDATA tessdata_fast



##############################
# Install necessary software
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache --virtual .build-deps build-base git sudo \
      libmagic leptonica-dev libpng-dev libjpeg tiff-dev zlib-dev \
      autoconf autoconf-archive automake libtool pkgconf file && \
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
    wget https://github.com/tesseract-ocr/${TESSDATA_TRAINEDDATA}/raw/master/eng.traineddata && \
    wget https://github.com/tesseract-ocr/${TESSDATA_TRAINEDDATA}/raw/master/osd.traineddata && \
    rm -rf /tmp/tesseract-ocr/ && \
    apk del .build-deps && \
    apk add --no-cache sudo imagemagick ghostscript bash \
      poppler-utils unpaper libmagic leptonica libpng libjpeg tiff zlib


WORKDIR /exchange

##############################
# Mount volumes
VOLUME ["/exchange"]

ENTRYPOINT ["tesseract"]
CMD ["--help"]


