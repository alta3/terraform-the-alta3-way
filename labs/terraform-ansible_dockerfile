FROM ubuntu:18.04

RUN apt-get update \
  && apt-get install -y \
     openssh-server \
     iproute2 \
     iputils-ping \
     vim \
     nano \
     screen \
     tcpdump \
     curl \
     python \
     less \ 
     python-pip \
     sudo
RUN mkdir /var/run/sshd
RUN echo 'root:alta3' | chpasswd

RUN rm -rf /usr/lib/python2.7/dist-packages/OpenSSL
RUN rm -rf /usr/lib/python2.7/dist-packages/pyOpenSSL-0.15.1.egg-info
RUN pip install --upgrade pip
RUN pip install -U pyopenssl
RUN useradd --create-home --shell /bin/bash student
RUN install -d -o student -g student /home/student/.ssh
RUN echo 'student:alta3' | chpasswd

# lines 15, 20-23 added to try and fix 'module' object has no attribute 'SSL_ST_INIT' problem

RUN useradd --create-home --shell /bin/bash ubuntu
RUN install -d -o ubuntu -g ubuntu /home/ubuntu/.ssh
RUN echo 'ubuntu:alta3' | chpasswd
RUN adduser ubuntu sudo

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22 
CMD ["/usr/sbin/sshd", "-D"]
