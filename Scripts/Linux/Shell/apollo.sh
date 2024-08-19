#!/bin/bash
#http://blog.51cto.com/brucewang/2141050
## 先安装jdk1.8以上到/usr/local/java 并设置系统环境变量
java -version
base_home="/home/test/Desktop"
############################################################################
dev_meta="http://192.168.2.1:8080,http://192.168.2.2:8080"
fat_meta="http://192.168.3.1:8080,http://192.168.3.2:8080"
uat_meta="http://192.168.4.1:8080,http://192.168.4.2:8080"
pro_meta="http://192.168.5.1:8080,http://192.168.5.2:8080"

########### portal 数据库 ，共用一个
# apollo portal db info
apollo_portal_db_url=jdbc:mysql://192.168.1.1:3306/ApolloPortalDB?characterEncoding=utf8
apollo_portal_db_password=portal_root_db_password

############ 四个环境的配置数据库
# apollo dev config db info
dev_apollo_config_db_url=jdbc:mysql://192.168.2.1:3306/ApolloConfigDB?characterEncoding=utf8
dev_apollo_config_db_password=dev_config_root_db_password
# apollo fat config db info
fat_apollo_config_db_url=jdbc:mysql://192.168.3.1:3306/ApolloConfigDB?characterEncoding=utf8
fat_apollo_config_db_password=fat_config_root_db_password
# apollo uat config db info
uat_apollo_config_db_url=jdbc:mysql://192.168.4.1:3306/ApolloConfigDB?characterEncoding=utf8
uat_apollo_config_db_password=uat_config_root_db_password
# apollo pro config db info
pro_apollo_config_db_url=jdbc:mysql://192.168.5.1:3306/ApolloConfigDB?characterEncoding=utf8
pro_apollo_config_db_password=pro_config_root_db_password

########################## 以下勿更改
build_sh() {
    cd "$base_home/apollo"
    cp -pr apollo apollo_$1
    cd apollo_$1/scripts
    # apollo config db info
    apollo_config_db_url=$2
    apollo_config_db_username=root
    apollo_config_db_password=$3
    # apollo portal db info
    apollo_portal_db_url=$4
    apollo_portal_db_username=root
    apollo_portal_db_password=$5
    # meta server url, different environments should have different meta server addresses
    dev_meta=$6
    fat_meta=$7
    uat_meta=$8
    pro_meta=$9
    META_SERVERS_OPTS="-Ddev_meta=$dev_meta -Dfat_meta=$fat_meta -Duat_meta=$uat_meta -Dpro_meta=$pro_meta"
    # =============== Please do not modify the following content =============== #
    # go to script directory
    cd "${0%/*}"
    cd ..
    # package config-service and admin-service
    echo "==== starting to build config-service and admin-service ===="
    mvn clean package -DskipTests -pl apollo-configservice,apollo-adminservice -am -Dapollo_profile=github -Dspring_datasource_url=$apollo_config_db_url -Dspring_datasource_username=$apollo_config_db_username -Dspring_datasource_password=$apollo_config_db_password
    echo "==== building config-service and admin-service finished ===="
    echo "==== starting to build portal ===="
    mvn clean package -DskipTests -pl apollo-portal -am -Dapollo_profile=github,auth -Dspring_datasource_url=$apollo_portal_db_url -Dspring_datasource_username=$apollo_portal_db_username -Dspring_datasource_password=$apollo_portal_db_password $META_SERVERS_OPTS
    echo "==== building portal finished ===="
    echo "==== starting to build client ===="
    mvn clean install -DskipTests -pl apollo-client -am $META_SERVERS_OPTS
    echo "==== building client finished ===="

}

####################初始化环境，下载apollo
sudo apt-get install -y maven git
sudo sed -i '/<mirrors>/a\<mirror> <id>nexus-aliyun</id> <mirrorOf>central</mirrorOf> <name>Nexus aliyun</name><url>http://maven.aliyun.com/nexus/content/groups/public/</url></mirror>' /etc/maven/settings.xml
mkdir -p apollo
cd apollo
git clone https://github.com/ctripcorp/apollo.git
source /etc/profile
sudo mv /usr/bin/java /usr/bin/java_bak
sudo ln -s /usr/local/java/bin/java /usr/bin/
###########################################

##### dev
build_sh "dev" "$dev_apollo_config_db_url" \
    "$dev_apollo_config_db_password" \
    "$apollo_portal_db_url" \
    "$apollo_portal_db_password" \
    "$dev_meta" "$fat_meta" "$uat_meta" "$pro_meta"
build_sh "fat" "$fat_apollo_config_db_url" \
    "$fat_apollo_config_db_password" \
    "$apollo_portal_db_url" \
    "$apollo_portal_db_password" \
    "$dev_meta" "$fat_meta" "$uat_meta" "$pro_meta"

build_sh "uat" "$uat_apollo_config_db_url" \
    "$uat_apollo_config_db_password" \
    "$apollo_portal_db_url" \
    "$apollo_portal_db_password" \
    "$dev_meta" "$fat_meta" "$uat_meta" "$pro_meta"

build_sh "pro" "$pro_apollo_config_db_url" \
    "$pro_apollo_config_db_password" \
    "$apollo_portal_db_url" \
    "$apollo_portal_db_password" \
    "$dev_meta" "$fat_meta" "$uat_meta" "$pro_meta"

######################### 添加本地jar包到本地mvn
dev_home="$base_home/apollo/apollo_dev"
apollo_version=`ls $dev_home/apollo-client/target/apollo-client-*.jar |grep -v sources |sed 's/.jar//g' |sed "s#.*apollo-client-##g"`
mvn install:install-file -DgroupId=com.ctrip.framework.apollo -DartifactId=apollo-client -Dversion=$apollo_version -Dpackaging=jar -Dfile=$dev_home/apollo-client/target/apollo-client-$apollo_version.jar
mvn install:install-file -DgroupId=com.ctrip.framework.apollo -DartifactId=apollo-core -Dversion=$apollo_version -Dpackaging=jar -Dfile=$dev_home/apollo-core/target/apollo-core-$apollo_version.jar
mvn install:install-file -DgroupId=com.ctrip.framework.apollo -DartifactId=apollo-buildtools -Dversion=$apollo_version -Dpackaging=jar -Dfile=$dev_home/apollo-buildtools/target/apollo-buildtools-$apollo_version.jar
mvn install:install-file -DgroupId=com.ctrip.framework.apollo -DartifactId=apollo-common -Dversion=$apollo_version -Dpackaging=jar -Dfile=$dev_home/apollo-common/target/apollo-common-$apollo_version.jar
#mkdir -p /opt/setting
#echo 'env=DEV' > /opt/setting/server.properties