FROM nimmis/java:14.04-oracle-8-jdk

ARG CDH_VERSION
ARG WORKSPACE
RUN echo "# Packages for Cloudera's Distribution for Hadoop, Version 5, on Ubuntu 14.04 amd64\n\
deb [arch=amd64] http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh${CDH_VERSION} contrib\n\
deb-src http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh${CDH_VERSION} contrib\n" > /etc/apt/sources.list.d/cloudera.list

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

# H2O
EXPOSE 54321
# HADOOP UI
EXPOSE 8088

COPY h2odriver.jar /home/h2o/

CMD "/usr/bin/startup.sh"
