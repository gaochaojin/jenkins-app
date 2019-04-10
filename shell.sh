#!/bin/bash
#kill tomcat pid
export BUILD_ID=tomcat-app_build_id

#1、关闭tomcat
pidlist=`ps -ef | grep tomcat-app | grep -v "grep" | awk '{print $2}'`
function stop(){
if [ "$pidlist" == "" ]
	then
		echo "--tomcat已经关闭--"
else
	echo "tomcat进程号：$pidlist"
	kill -9 $pidlist
fi
}

stop

pidlist2=`ps -ef | grep tomcat-app | grep -v "grep" | awk '{print $2}'`
if [ "$pidlist2" == "" ] 
	then
		echo "关闭tomcat成功"
else
	echo "关闭tomcat失败"		
fi

#2、移除原来tomcat中webapps中的项目文件夹
rm -rf /opt/app/tomcat-app/webapps/ROOT*

#3、复制jenkins生成的war包到tomcat中webapps中
cp /root/.jenkins/workspace/test/target/jenkins-app-1.0.war /opt/app/tomcat-app/webapps

sleep 3s

#4、修改war包的名称
mv /opt/app/tomcat-app/webapps/jenkins-app-1.0.war /opt/app/tomcat-app/webapps/ROOT.war

#5、启动tomcat
cd /opt/app/tomcat-app/bin
./startup.sh
