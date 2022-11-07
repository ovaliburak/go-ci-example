Use apt-get to install the required packages.
 - apt-get update
 - apt-get install unzip software-properties-common wget default-jdk
 
Install the PostgreSQL database service.
 - apt-get install postgresql postgresql-contrib
 
Access the Postgres database service command-line.
 - su - postgres
 - psql
 
Create a Postgres user named sonarqube,Create a Postgres database named sonarqube.
Give the PostgreSQL user named sonarqube permission over the database named sonarqube
 - CREATE USER sonarqube WITH PASSWORD 'password';
 - CREATE DATABASE sonarqube OWNER sonarqube;
 - GRANT ALL PRIVILEGES ON DATABASE sonarqube TO sonarqube;
 - \q
 
Download the Sonarqube package and move it to the OPT directory.
 - mkdir /downloads/sonarqube -p
 - cd /downloads/sonarqube
 - wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.9.1.zip
 - unzip sonarqube-7.9.1.zip
 - mv sonarqube-7.9.1 /opt/sonarqube
 
Create a new Linux account named sonarqube, Set the correct file permission on the sonarqube directory.
 - adduser --system --no-create-home --group --disabled-login sonarqube
 - chown -R sonarqube:sonarqube /opt/sonarqube
 
Edit the sonar.sh configuration file.
 - vi /opt/sonarqube/bin/linux-x86-64/sonar.sh
 
Configure the following options:
 - RUN_AS_USER=sonarqube
 
Edit the sonar.properties configuration file.
 - vi /opt/sonarqube/conf/sonar.properties
 
Configure the following options:

      sonar.jdbc.username=sonarqube
      sonar.jdbc.password=password
      sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube
      sonar.web.javaAdditionalOpts=-server
      sonar.web.host=0.0.0.0
		
Create a Linux configuration file named 99-sonarqube.conf
 - vi /etc/security/limits.d/99-sonarqube.conf
 
Here  is the content of the 99-sonarqube.conf file.
		
    sonarqube   -   nofile   65536
    sonarqube   -   nproc    4096

Edit the sysctl.conf configuration file.
 - vi /etc/sysctl.conf
 
Add the following lines at the end of the sysctl.conf file.

      vm.max_map_count=262144
      fs.file-max=65536

Reboot your computer to enable the new configuration
 - reboot
 
Start the Sonarqube service.
 - /opt/sonarqube/bin/linux-x86-64/sonar.sh start
 
Use the following command to monitor the SonarQube log.
 -  tail -f /opt/sonarqube/logs/sonar.log

for more deatils refer - https://techexpert.tips/sonarqube/sonarqube-installation-ubuntu-linux/