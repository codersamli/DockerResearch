FROM microsoft/windowsservercore
####### PORTS ########
#Main rabbitmq port
EXPOSE 5672
#port mapper daemon (epmd)
EXPOSE 4369
#inet_dist_listen
EXPOSE 35197
#rabbitmq management console
EXPOSE 15672
#set the home directory for erlang so rabbit can find it easily
ENV ERLANG_HOME "c:\program files\erl8.3\erts-8.3"
ENV ERLANG_SERVICE_MANAGER_PATH "C:\Program Files\erl8.3\erts-8.3\bin"
####### ENV ##########
#proxy
ENV chocolateyUseWindowsCompression false
ENV chocolateyProxyLocation 'http://comproxy.utc.com:8080/'
#environment variables of rabbitmq
ENV RABBITMQ_SERVER="C:\Program Files\RabbitMQ Server\rabbitmq_server-3.6.10"
ENV RABBITMQCTL="C:\Program Files\RabbitMQ Server\rabbitmq_server-3.6.10\sbin"
ENV RABBIT_MQ_HOME "C:\Program Files\RabbitMQ Server\rabbitmq_server-3.6.10"
#set up the path to the config file
ENV RABBITMQ_CONFIG_FILE "C:\rabbitmq.config"
####### INSTALL ######
#install chocolatey
RUN @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
#install curl
RUN choco install -y curl
#install erlang
RUN choco install -y erlang --version 19.3
#install rabbitmq
RUN choco install -y rabbitmq --version 3.6.10
####### COPY #########
#copy a config file over
COPY rabbitmq.config C:/
COPY rabbitmq.config C:/Users/ContainerAdministrator/AppData/Roaming/RabbitMQ/
COPY enabled_plugins C:/Users/ContainerAdministrator/AppData/Roaming/RabbitMQ/
#set the startup command to be rabbit
CMD ["C:\\Program Files\\RabbitMQ Server\\rabbitmq_server-3.6.10\\sbin\\rabbitmq-server.bat"]