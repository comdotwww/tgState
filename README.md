tgState
==

[English](./README_en.md) 

一款以Telegram作为储存的文件外链系统

不限制文件大小和格式

可以作为telegram图床，也可以作为telegram网盘使用。

支持web上传文件和telegram直接上传

[搭配CLoudFlare使用](./CloudFlare.md)


# 参数说明

必填参数

 - target
 - token

可选参数

 - pass
 - mode
 - url
 - port

## target

目标可为频道、群组、个人

当目标为频道时，需要将Bot拉入频道作为管理员，公开频道并自定义频道Link，target值填写Link，如@xxxx

当目标为群组时，需要将Bot拉入群组，公开群组并自定义群组Link，target值填写Link，如@xxxx

当目标为个人时，则为telegram id(@getmyid_bot获取)

## token

填写你的bot token

## pass

填写访问密码，如不需要，直接填写```none```即可

## mode

 - ```p``` 代表网盘模式运行，不限制上传后缀
 - ```m``` 在p模式的基础上关闭网页上传，可私聊进行上传（如果target是个人，则只支持指定用户进行私聊上传

## url

bot获取FileID的前置域名地址自动补充及api返回完整url的补充

## port

自定义运行端口

# 管理

## 获取FIleID

对bot聊天中的文件引用并回复```get```可以获取FileID，搭建地址+获取的path即可访问资源

如果配置了url参数，会直接返回完整的地址

![image](https://tgstate.vercel.app/d/BQACAgUAAx0EcyK3ugACEv5mSJc6qUVSeJmsWBf2LEgu7FOw1wACCw4AAjw_SVaIQCHT6DFDfTUE)

# 部署

## 二进制
编译
```bash
go build -tags netgo -o tgState
```
<details>
 <summary>推荐自行编译</summary>
Linux amd64下载

```
wget https://github.com/csznet/tgState/releases/latest/download/tgState.zip && unzip tgState.zip && rm tgState.zip
```

Linux arm64下载

```
wget https://github.com/csznet/tgState/releases/latest/download/tgState_arm64.zip && unzip tgState_arm64.zip && rm tgState_arm64.zip
```

Linux 一键脚本

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/csznet/tgState/main/get.sh)"
```
</details>

**使用方法**

```
 ./tgState 参数
```

**例子**
```
 ./tgState -token xxxx -target @xxxx
```

**后台运行**

```
nohup ./tgState 参数 &
```

## Docker

pull镜像
```
docker pull csznet/tgstate:latest
```

启动
```
docker run -d -p 8088:8088 --name tgstate 参数 --net=host csznet/tgstate:latest
```
其中docker的参数需要设置为环境变量

开机自启需要加上
```
--restart always
```


**例子**
```
docker run -d -p 8088:8088 --name tgstate -e token=token -e target=@target -e mode=p --net=host csznet/tgstate:latest
```

## Docker Compose
### 编译二进制文件
```bash
go build -tags netgo -o tgState
```
### 修改 docker-compose.yml文件
配置 mode、target、token、pass、url，其中mode、target、token必填

配置好后执行：
```bash
docker-compose up -d
```

## Vercel

不支持大于5mb文件，不支持tg获取文件路径

 [点我传送至Vercel配置页面](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fcomdotwww%2FtgState&env=token&env=target&env=pass&env=mode&env=url&project-name=tgState&repository-name=tgState)  

# API说明

POST方法到路径```/api```

表单传输，字段名为image，内容为二进制数据  

当设置访问密码时，直接将密码加入url参数pass中，如密码为123：

```
/api?pass=123
```

返回示例:  

```json
{"code": 1, "message": "/d/xxx","url":"xxx"}
```

json格式的`url`默认返回tgState的`url`参数+访问路径，如果只得到了路径则需要自行设置`url`参数

picgo-plugin-web-uploader填写说明：  

POST参数名：`image`  

JSON路径：`url`

![Alt Text](https://tgstate.vercel.app/d/BQACAgUAAx0EcyK3ugACEv9mSJiKqRd2Ujfcba465TK8VY6WCAACFg4AAjw_SVbi1kv6ix4flzUE)


