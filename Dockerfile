FROM arm32v6/alpine:3.23

RUN apk add --update --no-cache python3 py3-pip py3-numpy py3-pillow py3-psutil py3-yaml py3-paho-mqtt
