ROM alpine:latest

# 将编译好的 二进制文件复制到容器中
COPY ./tgState /app/

# 设置工作目录
WORKDIR /app

# 设置暴露的端口
EXPOSE 8088


# 设置容器启动时要执行的命令
CMD  [ "/app/tgState" ]
