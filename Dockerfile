FROM  ubuntu:14.04
MAINTAINER Paul Ingles <paul@oobaloo.co.uk>

RUN apt-get update
RUN apt-get install -y supervisor

ADD https://web-dl.packagecloud.io/basho/riak/packages/ubuntu/trusty/riak_2.0.2-1_amd64.deb /tmp/riak.deb
RUN dpkg -i /tmp/riak.deb

WORKDIR /tmp
ADD https://github.com/coreos/etcd/releases/download/v0.4.6/etcd-v0.4.6-linux-amd64.tar.gz /tmp/etcd.tar.gz
RUN tar zxvf etcd.tar.gz
RUN mv ./etcd-v0.4.6-linux-amd64/etcdctl /usr/bin/etcdctl

ADD https://dl.bintray.com/mitchellh/consul/0.4.1_linux_amd64.zip /tmp/consul.zip
RUN unzip consul.zip
RUN chmod +x consul
RUN mv consul /bin/consul
RUN rm consul.zip

ADD riak-start-bootstrap /usr/sbin/riak-start-bootstrap
ADD riak-join /usr/sbin/riak-join

ADD riak.conf /tmp/riak.conf
RUN cat /tmp/riak.conf >> /etc/riak/riak.conf
RUN rm /tmp/riak.conf

ADD riak.env /tmp/riak.env
RUN cat /tmp/riak.env >> /usr/lib/riak/lib/env.sh
RUN rm /tmp/riak.env

ADD supervisord.conf /etc/supervisord.conf

ADD riak.defaults /etc/default/riak

EXPOSE 8087 8098 8099 4369 5000

VOLUME ["/data", "/logs"]

ENTRYPOINT ["/usr/sbin/riak-start-bootstrap"]
CMD []