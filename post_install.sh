export projectslug=cloudstore
export projectgit=${projectslug}.git
export projectDB=${projectslug}_db
export projectDBuser=${USER}_user

sudo mkdir /var/www/
sudo mkdir /var/www/${projectslug}/
cd ~/
ln -s /var/www/${projectslug}/ ~/
mkdir /var/repo/
mkdir /var/repo/${projectgit}/
cd /var/repo/${projectgit}/

git clone https://github.com/codingforentrepreneurs/CFE-Blank-Project . --bare
git --work-tree="/var/www/${projectslug}" --git-dir="/var/repo/${projectgit}" checkout -f
virtualenv -p python3.6 /var/www/${projectslug}
cd /var/www/${projectslug}/src/
sudo rm -f /var/www/${projectslug}/src/cfehome/
virtualenvbin="/var/www/${projectslug}/bin"
$virtualenvbin/python -m pip install -r "/var/www/${projectslug}/src/requirements.txt"
















if true
then
    git clone https://github.com/FusionArc/DjangoBoiler.git . --bare
    git --work-tree="/var/www/${projectslug}" --git-dir="/var/repo/${projectgit}" checkout -f
    cd  /var/www/${projectslug}
    virtualenv -p python3.6 /var/www/${projectslug}
    #sudo rm /var/www/${projectslug}/src/cfehome/settings/local.py
    virtualenvbin=/var/www/${projectslug}/bin
    ${virtualenvbin}/python -m pip install -r /var/www/${projectslug}/requirements.txt
    source ${virtualenvbin}/activate
fi  
sudo chmod +x /var/repo/${projectgit}/hooks/post-receive

#cat <<EOT >>
#/var/repo/${projectgit}/hooks/post-receive

# Run this on your local repo:
# echo "git remote add live ssh://${USER}@${localip}/var/repo/${projectgit}"

if [ x == x ]
then
    cd /var/www/${projectslug}/
fi

if true
then
# cd  /tmp
#su postgres
    sudo -u postgres createuser $USER

    sudo -u postgres createdb ${projectDB}

    sudo -u postgres psql --command="CREATE DATABASE ${projectDB};"

    sudo -u postgres psql --command="CREATE USER ${projectDBuser} WITH PASSWORD '${newPassword}';"

    sudo -u postgres psql --command="ALTER ROLE ${projectDBuser} SET client_encoding TO 'utf8';"

    sudo -u postgres psql --command="ALTER ROLE ${projectDBuser} SET default_transaction_isolation TO 'read committed';"

    sudo -u postgres psql --command="GRANT ALL PRIVILEGES ON DATABASE ${projectDB} TO ${projectDBuser};"
    
    sudo -u postgres psql --command="ALTER ROLE ${projectDBuser} SET timezone TO 'UTC';"

fi
    cd ~/ 