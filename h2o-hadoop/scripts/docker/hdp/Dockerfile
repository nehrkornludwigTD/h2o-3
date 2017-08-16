FROM nimmis/java:14.04-oracle-8-jdk

WORKDIR /

ARG VERSION

COPY scripts/add_hdp_repo.sh /usr/sbin/add_hdp_repo.sh
RUN chmod 700 /usr/sbin/add_hdp_repo.sh
RUN /usr/sbin/add_hdp_repo.sh $VERSION

RUN apt-get install -y hadoop-conf-pseudo python-dev python-pip python-scipy
RUN pip install requests --upgrade
RUN pip install colorama future tabulate pandas

COPY conf/hadoop-env.sh /etc/hadoop/conf/hadoop-env.sh
COPY conf/core-site.xml /etc/hadoop/conf/core-site.xml

RUN hadoop namenode -format -force

EXPOSE 54321

RUN useradd -ms /bin/bash h2o

COPY "scripts/hdfs_start" "/etc/startup/00_hdfs_start"
RUN chmod 700 "/etc/startup/00_hdfs_start"

COPY "scripts/hdfs_setup" "/etc/startup/10_hdfs_setup"
RUN chmod 700 "/etc/startup/10_hdfs_setup"

COPY "scripts/hdfs_create_h2o_home" "/etc/startup/20_hdfs_create_h2o_home"
RUN chmod 700 "/etc/startup/20_hdfs_create_h2o_home"

COPY "scripts/yarn_start" "/etc/startup/30_yarn_start"
RUN chmod 700 "/etc/startup/30_yarn_start"

COPY "scripts/init_h2o" "/etc/startup/40_init_h2o"
RUN chmod 700 "/etc/startup/40_init_h2o"

COPY "scripts/startup.sh" "/usr/bin/startup.sh"
RUN chmod +x /usr/bin/startup.sh

# H2O
EXPOSE 54321
# HADOOP UI
EXPOSE 8088

ENV VERSION $VERSION
ENV INIT_H2O TRUE
ENV RUN_TESTS TRUE
ENV ENTER_BASH FALSE


CMD "/usr/bin/startup.sh"
