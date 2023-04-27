FROM gcr.io/instruqt-images-330918/java8base:1.0
WORKDIR /root

RUN wget https://dlcdn.apache.org/druid/24.0.2/apache-druid-24.0.2-bin.tar.gz \
&& tar -xzf apache-druid-24.0.2-bin.tar.gz \
&& gunzip /root/apache-druid-24.0.2/quickstart/tutorial/wikiticker-2015-09-12-sampled.json.gz

CMD ["/bin/bash"]
