#!/bin/bash -eu

repodir="$(cd $(dirname -- "$0")/..; pwd)"

cd $repodir
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew upgrade
brew update
# Install Homebrew and/or make sure it is up to date.

brew install python
# Homebrew installs Python 2.7.
# To install Python 3, do `brew install python3`.
# Homebrew installs Setuptools and pip for you.

brew install libmagic
# Error when running server because cannot find module libmagic.
# Install libmagic.
# Source:  http://www.brambraakman.com/blog/comments/installing_libmagic_in_mac_os_x_for_python-magic/

brew install node
# Homebrew installs both Node and NPM

npm install


brew install curl
# Homebrew installs curl.


sudo -H pip install -r requirements.txt
sudo -H pip install -r tests/requirements.txt
# Added -H flag becase had permission issues.

# ============== mongo ====================
brew install mongodb
brew install mongodb --with-openssl
brew install mongodb --devel
sudo mkdir -p /data/db

sudo chmod 755 /data/db && sudo chown $USER /data/db
# Setting permissions for /data/db access.
# Source: http://stackoverflow.com/questions/41420466/mongodb-shuts-down-with-code-100

sudo chmod -R 777 /data/db
sudo chown -R `id-un` /data/db
# Want to be able to start mongod without having to type sudo mongod.
# Source: http://stackoverflow.com/questions/26305279/dont-want-to-have-to-start-mongod-with-sudo-mongod

mongo --port 27017 truedata --eval "db.createUser({user: 'atlas', pwd: 'local', roles: ['userAdmin', 'readWrite']})"
mongo --port 27017 dumpster --eval "db.createUser({user: 'atlas', pwd: 'local', roles: ['userAdmin', 'readWrite']})"
# If above section breaks, make sure you are running mongod in a separate tab.


# ============= data ===================
echo "Dumping data from staging"
# ssh olympus.recruiter.ai "rm -rf dump && mongodump -dtruedata && mongodump -ddumpster && tar -zcvf dump.tgz dump/ && rm -r dump"
# rsync -Pav olympus.recruiter.ai:~/dump.tgz .
# tar -zxvf dump.tgz
# mongorestore -uatlas -plocal dump
# ssh olympus.recruiter.ai "rm -rf dump.tgz"
 rsync -Pav olympus.recruiter.ai:/data/backups/small.latest.tgz .
 tar -zxvf small.latest.tgz
 mongorestore all-*
 rm -r all-* small.latest.tgz

# The following would be better because dump is pre-compressed, but need to think how to allow access to it
# rsync mongo:/backups/all.latest.tar.xz .
# mongorestore -dtruedata all-2017-04-05-05-00-01/truedata/
# mongorestore -ddumpster all-2017-04-05-05-00-01/dumpster/
# rm all.latest.tar.xz

./manage.py collectstatic --noinput

# ============= postfix ===================
if [[ "$(uname -a)" = Darwin* ]]; then
    echo "postfix auto-installation not supported on mac. Please implement"
else
  sudo DEBIAN_FRONTEND=noninteractive apt-get install postfix
  read -p "Enter gmail user: " email
  read -sp "Enter gmail password: " pass
  echo ""
  echo "[smtp.gmail.com]:587    ${email}:${pass}" | sudo tee /etc/postfix/sasl_passwd > /dev/null
  sudo postmap hash:/etc/postfix/sasl_passwd
  sudo chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
  sudo chmod 0600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
  marker="uncommonSetting"
  sudo sed "/${marker}/Q" /etc/postfix/main.cf -i
  sudo cat <<EOF | sudo tee -a /etc/postfix/main.cf
  	#$marker
  	relayhost = [smtp.gmail.com]:587
  	smtp_use_tls = yes
  	smtp_sasl_auth_enable = yes
  	smtp_sasl_security_options = noanonymous
  	smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
  	smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
EOF
  sudo service postfix stop
  sudo service postfix start
fi
