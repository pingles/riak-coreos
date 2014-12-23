FROM  ubuntu:14.04
MAINTAINER Paul Ingles <paul@oobaloo.co.uk>

ADD https://web-dl.packagecloud.io/basho/riak/packages/ubuntu/trusty/riak_2.0.2-1_amd64.deb /tmp/riak.deb
RUN dpkg -i /tmp/riak.deb


WORKDIR /tmp
ADD https://github.com/coreos/etcd/releases/download/v0.4.6/etcd-v0.4.6-linux-amd64.tar.gz /tmp/etcd.tar.gz
RUN tar zxvf etcd.tar.gz
RUN mv ./etcd-v0.4.6-linux-amd64/etcdctl /usr/bin/etcdctl

ADD riak-start-bootstrap /usr/sbin/riak-start-bootstrap
ADD riak-join /usr/sbin/riak-join

ADD riak.defaults /etc/default/riak

EXPOSE 8087 8098 8099 4369

ENTRYPOINT ["/usr/sbin/riak-start-bootstrap"]
CMD []