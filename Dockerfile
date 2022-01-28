FROM alpine:latest

ENV TERRAFORM_VERSION=1.0.8
ENV TERRAFORM_PROVIDER_AZURERM=2.8.0
ENV TERRAFORM_PROVIDER_CLOUDFLARE=2.6.0
ENV TERRAFORM_PROVIDER_PINGDOM=1.1.1
ENV TERRAFORM_PROVIDER_K8S=0.7.6
ENV TERRAFORM_PROVIDER_VAULT=2.10.0

RUN apk add --update bash curl openssl

ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ./

RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin
RUN rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip


RUN ["addgroup", "-S", "argo"]
RUN ["adduser", "-S", "-D", "-h", "/home/argo", "-G", "argo", "argo"]
RUN ["mkdir", "-p", "/home/argo/terraform.d/plugins/linux_amd64/"]

#COPY ./terraform/ /home/argo/terraform/

RUN chown argo:argo -R /home/argo
RUN chmod +x -R /home/argo/terraform.d/plugins/linux_amd64/
RUN chmod 755 -R /home/argo/
USER root
WORKDIR /home/argo/