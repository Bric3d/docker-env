FROM		debian

MAINTAINER	bbecker brice@b3cker.fr

ENV			HOSTNAME Mothership
RUN			apt-get update && apt-get install -y openssh-server

RUN			sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

ADD			files/ssh/id_rsa.pub /root/.ssh/authorized_keys

RUN			sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV			NOTVISIBLE "in users profile"
RUN			echo "export VISIBLE=now" >> /etc/profile

EXPOSE		22

RUN			/etc/init.d/ssh restart
ENTRYPOINT	/usr/sbin/sshd -D
