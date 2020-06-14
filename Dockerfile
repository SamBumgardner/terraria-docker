FROM ubuntu:20.04

# Install AWS CLI for retrieving server backup save from S3
RUN apt update
RUN apt install -y python3-pip
RUN pip3 install awscli

# Install small, fundamental dependencies
RUN apt install -y sudo bash wget unzip

# Copy startup script
ADD startup.sh /bin/startup.sh

ENTRYPOINT [ "/bin/startup.sh" ]