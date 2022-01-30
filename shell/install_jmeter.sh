#!/bin/sh

echo "Installing Java"

# Install Java
sudo yum install java -y

echo "Installing JMeter..."

curl -L --silent ${JMETER_DOWNLOAD_URL} > ${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}.tgz
tar -xzf ${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}.tgz -C ${JMETER_HOME}
rm -f ${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}.tgz

echo "Installing JMeter plugins..."
pwd
ls
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
sudo java -cp ${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}/lib/ext/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller

sudo ${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}/bin/PluginsManagerCMD.sh help

STATUS=$?
if [ $STATUS -eq 0 ];then
   echo "JMeter and its plugins installed successfully!"
   sudo echo "PATH=${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}/bin:$PATH" >> ${JMETER_HOME}/.bashrc
   sudo source ${JMETER_HOME}/.bashrc
   echo "${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}/bin" + " is added to PATH"
fi
