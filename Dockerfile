FROM centos

COPY ./CrashPlan_4.5.0_Linux.tgz /CrashPlan_4.5.0_Linux.tgz

RUN yum -y update
RUN yum -y install \
grep \
sed \
cpio \
gzip \
coreutils \
which

RUN tar xpzf /CrashPlan_4.5.0_Linux.tgz -C /opt/ && rm -rf /CrashPlan_4.5.0_Linux.tgz

COPY ./custom-install.sh /opt/crashplan-install/install.sh
RUN mkdir -p /crashplan

WORKDIR /opt/crashplan-install
RUN bash ./install.sh
RUN rm -rf /opt/crashplan-install

EXPOSE 4242/tcp 4243/tcp

WORKDIR /crashplan/crashplan
run sed -i 's/nice\ -n\ 19\ \$JAVACOMMON\ \$SRV_JAVA_OPTS\ -classpath\ \$FULL_CP\ com\.backup42\.service\.CPService.*/nice -n 19 $JAVACOMMON $SRV_JAVA_OPTS -classpath $FULL_CP com.backup42.service.CPService/' bin/CrashPlanEngine

RUN for app in cpio curl python passwd tar diff sdiff hostname; do chmod 444 $(which $app); done

COPY ./linker.sh /crashplan/linker.sh
COPY ./entrypoint.sh /crashplan/entrypoint.sh
RUN chmod a+x /crashplan/linker.sh /crashplan/entrypoint.sh

ENTRYPOINT /crashplan/entrypoint.sh
