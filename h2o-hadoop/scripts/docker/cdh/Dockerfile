FROM nimmis/java:14.04-oracle-8-jdk

ARG VERSION
ARG WORKSPACE
RUN echo "# Packages for Cloudera's Distribution for Hadoop, Version 5, on Ubuntu 14.04 amd64\n\
deb [arch=amd64] http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh${VERSION} contrib\n\
deb-src http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh${VERSION} contrib\n" > /etc/apt/sources.list.d/cloudera.list

# Set preference for cloudera packages
COPY conf/cloudera.pref /etc/apt/preferences.d/cloudera.pref

RUN wget http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key -O archive.key && sudo apt-key add archive.key && \
    sudo apt-get update

RUN apt-get install -y hadoop-conf-pseudo

RUN service hadoop-hdfs-namenode init

# Add H2O user
RUN useradd -ms /bin/bash h2o

COPY "scripts/startup.sh" "/usr/bin/startup.sh"
RUN chmod +x /usr/bin/startup.sh

COPY "scripts/hdfs_start" "/usr/sbin/hdfs_start"
RUN chmod 700 "/usr/sbin/hdfs_start"
COPY "scripts/hdfs_setup" "/usr/sbin/hdfs_setup"
RUN chmod 700 "/usr/sbin/hdfs_setup"
COPY "scripts/hdfs_create_h2o_home" "/usr/sbin/hdfs_create_h2o_home"
RUN chmod 700 "/usr/sbin/hdfs_create_h2o_home"
COPY "scripts/yarn_start" "/usr/sbin/yarn_start"
RUN chmod 700 "/usr/sbin/yarn_start"

# H2O
EXPOSE 54321
# HADOOP UI
EXPOSE 8088

CMD "/usr/bin/startup.sh"
