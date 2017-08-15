FROM nimmis/java:14.04-oracle-8-jdk

WORKDIR /

ARG VERSION

COPY scripts/add_hdp_repo.sh /usr/sbin/add_hdp_repo.sh
RUN chmod 700 /usr/sbin/add_hdp_repo.sh
RUN /usr/sbin/add_hdp_repo.sh $VERSION

RUN apt-get install -y hadoop-conf-pseudo

COPY conf/hadoop-env.sh /etc/hadoop/conf/hadoop-env.sh
COPY conf/core-site.xml /etc/hadoop/conf/core-site.xml

RUN hadoop namenode -format -force

EXPOSE 54321

RUN useradd -ms /bin/bash h2o

COPY scripts/startup.sh /usr/bin/startup.sh
RUN chmod +x /usr/bin/startup.sh

COPY "scripts/hdfs_start" "/usr/sbin/hdfs_start"
RUN chmod 700 "/usr/sbin/hdfs_start"
COPY "scripts/hdfs_setup" "/usr/sbin/hdfs_setup"
RUN chmod 700 "/usr/sbin/hdfs_setup"
COPY "scripts/hdfs_create_h2o_home" "/usr/sbin/hdfs_create_h2o_home"
RUN chmod 700 "/usr/sbin/hdfs_create_h2o_home"
COPY "scripts/yarn_start" "/usr/sbin/yarn_start"
RUN chmod 700 "/usr/sbin/yarn_start"

CMD "/usr/bin/startup.sh"
