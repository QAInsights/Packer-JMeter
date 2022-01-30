#!/bin/sh
JMETER_HOME="/home/ec2-user"
JMETER_VERSION="5.4.3"
JMETER_DOWNLOAD_URL="https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz"
JMETER_CMDRUNNER_VERSION="2.2"
JMETER_CMDRUNNER_DOWNLOAD_URL="http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/${JMETER_CMDRUNNER_VERSION}/cmdrunner-${JMETER_CMDRUNNER_VERSION}.jar"
JMETER_PLUGINS_MANAGER_VERSION="1.7"
JMETER_PLUGINS_MANAGER_DOWNLOAD_URL="https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-manager/${JMETER_PLUGINS_MANAGER_VERSION}/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar"
JMETER_PLUGINS="jpgc-casutg,jpgc-functions"

# echo ${JMETER_HOME}
# echo ${JMETER_VERSION}
# echo ${JMETER_DOWNLOAD_URL}
# echo ${JMETER_CMDRUNNER_VERSION}
# echo ${JMETER_CMDRUNNER_DOWNLOAD_URL}
# echo ${JMETER_PLUGINS_MANAGER_VERSION}
# echo ${JMETER_PLUGINS_MANAGER_DOWNLOAD_URL}
# echo ${JMETER_PLUGINS}

echo "Installing Java"

# Install Java
sudo yum install java -y

echo "Installing JMeter..."

curl -L --silent ${JMETER_DOWNLOAD_URL} > ${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}.tgz
tar -xzf ${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}.tgz -C ${JMETER_HOME}
rm -f ${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}.tgz

echo "Installing JMeter plugins..."

# Download CMDRunner plugin
curl -L --silent ${JMETER_CMDRUNNER_DOWNLOAD_URL} > ${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}/lib/cmdrunner-${JMETER_CMDRUNNER_VERSION}.jar

# Download JMeter Plugins Manager
curl -L --silent ${JMETER_PLUGINS_MANAGER_DOWNLOAD_URL} > ${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}/lib/ext/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar

# Installing JMeter Plugins
for i in $(echo ${JMETER_PLUGINS} | tr ',' '\n')
do
sudo java -jar ${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}/lib/cmdrunner-${JMETER_CMDRUNNER_VERSION}.jar --tool org.jmeterplugins.repository.PluginManagerCMD install $i
done

# Generating Plugin Manager CMD in bin
java -cp ${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}/lib/ext/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller

${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}/bin/PluginsManagerCMD.sh help

STATUS=$?
if [ $STATUS -eq 0 ];then
   echo "JMeter and its plugins installed successfully!"
   echo "PATH=${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}/bin:$PATH" >> ${JMETER_HOME}/.bashrc
   source ${JMETER_HOME}/.bashrc
   echo "${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}/bin" + " is added to PATH"
fi
