export projectslug=cloudstore
export projectgit="${projectslug}".git
export projectDB="${projectslug}"_db
export USERNAME=davecheez
export USER=davecheez21_gmail_com
export projectDBuser="${USERNAME}"_user
export localip="34.76.126.193"
export GIT_DIR=/var/repo/"${projectgit}"
export GIT_WORK_TREE=/var/www/"${projectslug}"
export virtualenvbin="/var/www/$projectslug/bin"

echo
echo "Use default blank django project? (y/n)"
read defaultDjangoProject
defaultDjangoProjectResponse="$(echo -n '${defaultDjangoProject}' | sed -e 's/[^[:alnum:]]/-/g' | tr -s '_' | tr A-Z a-z)"

sudo mkdir /var/www/"$projectslug"/
cd ~/
ln -s /var/www/"$projectslug"/ ~/

sudo mkdir /var/repo/
sudo mkdir /var/repo/"$projectgit"/
sudo chmod 775 --recursive /home/"$USER"/
sudo chmod 775 --recursive /var/repo/
sudo chmod 775 --recursive /var/www/

git config --global core.autocrlf input

cd /var/repo/"$projectgit"/
git clone git@github.com:DaveCheez/DjangoBoiler.git . --bare
git --work-tree="/var/www/$projectslug" --git-dir="/var/repo/$projectgit" checkout -f
virtualenv -p python3.6 /var/www/"$projectslug"
cd /var/www/"$projectslug"/

"$virtualenvbin"/python3 -m pip install -r /var/www/"$projectslug"/requirements.txt

cat <<EOT >> /var/repo/"$projectgit"/hookS/post-receive
git --work-tree=/var/www/"$projectslug" --git-dir=/var/repo/"$projectgit" checkout -f

"$virtualenvbin"/python3 -m pip install -r /var/www/"$projectslug"/requirements.txt

supervisorctl reread
supervisorctl update
EOT

chmod +x /var/repo/"$projectgit"/hooks/post-receive

exit 0

