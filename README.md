#### Jenkins使用

##### Jenkins安装、部署和运行

- 下载地址;<https://jenkins.io/>，下载war，在tomcat中运行
- 访问<http://localhost:9000/jenkins/>
- 选择推荐插件安装
- 创建管理员用户（gaochaojin/18770081419***）

##### Jenkins配置

- ##### 基本配置

  ###### 进入系统管理--全局工具配置

  - JDK配置
  - git配置  安装git（yum -y install git）
  - Maven配置

- ##### 插件配置

  ###### 进入系统管理--插件管理

  - Maven插件：Maven Integration
  - 动态部署插件：Deploy to container

##### Jenkins自动构建部署

- ##### Jenkins配置程序作业

  - 构建maven项目

  - 源码管理

    使用git进行远程管理，需要填写项目git地址，用户名和密码

  - 构建触发器（手动，定时，轮询）

  - 构建包操作

    WAR/EAR files/Context path/Containers(需要填写tomcat管理的账户和密码以及访问链接)

    tomcat-app的配置为：

    - 开放热部署访问限制：/opt/app/tomcat-app/webapps/manager/META-INF目录下的文件contex.xml,注释标签context中的标签value

      ```xml
      <Context antiResourceLocking="false" privileged="true" >
      <!--  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
               allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />  -->
        <Manager sessionAttributeValueClassNameFilter="java\.lang\.(?:Boolean|Integer|Long|Number|String)|org\.apache\.catalina\.filters\.CsrfPreventionFilter\$LruCache(?:\$1)?|java\.util\.(?:Linked)?HashMap"/>
      </Context>
      ```

    - 修改tomcat用户信息：/opt/app/tomcat-app/conf目录下的tomcat-users.xml,在标签tomcat-users中增加

      ```xml
      <role rolename="manager-gui"/>
      <role rolename="manager-script"/>
      <role rolename="admin-gui"/>
      <role rolename="admin-script"/>
      <role rolename="tomcat-gui"/>
      <user username="tomcat" password="123456" roles="manager-gui,manager-script,admin-gui,admin-script,tomcat"/>
      ```

    - 访问链接：http://localhost:9001/manager/html   tomcat/123456