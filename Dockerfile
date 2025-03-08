FROM clojure:temurin-21-tools-deps-1.12.0.1479-jammy
WORKDIR /app
# COPY . /app

# Explicit Maven settings file creation
ARG CLOJARS_USERNAME
ARG CLOJARS_PASSWORD

RUN mkdir -p /root/.m2 
ADD etc/settings.xml /root/.m2/settings.xml

RUN pwd && cat /root/.m2/settings.xml
