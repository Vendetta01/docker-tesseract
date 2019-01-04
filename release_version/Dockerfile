FROM alpine:edge


##############################
# Install necessary software
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache bash tesseract-ocr tesseract-ocr-data-deu
#    apk add --no-cache sudo imagemagick ghostscript bash \
#      poppler-utils unpaper tesseract-ocr tesseract-ocr-data-deu


WORKDIR /exchange

##############################
# Mount volumes
VOLUME ["/exchange"]

ENTRYPOINT ["tesseract"]
CMD ["--help"]



