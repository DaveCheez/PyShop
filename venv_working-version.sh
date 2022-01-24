export projectslug=cloudstore
export projectgit=${projectslug}.git
export projectDB=${projectslug}_db
export USERNAME=davecheez
export projectDBuser=${USERNAME}_user
export localip="34.76.126.193"
export GIT_DIR=${HOME}/repo/${projectgit}/
export GIT_WORK_TREE=${HOME}/src/${projectslug}/
export VENVBIN=${HOME}/src/${projectslug}/bin

echo
echo "Use default blank django project? (y/n)"

read defaultDjangoProject
defaultDjangoProjectResponse="$(echo -n '${defaultDjangoProject}' | sed -e 's/[^[:alnum:]]/-/g' | tr -s '_' | tr A-Z a-z)"

sudo mkdir ${HOME}/src
sudo mkdir ${HOME}/repo

sudo mkdir $GIT_WORK_TREE
sudo mkdir $GIT_DIR

sudo chmod 775 --recursive ${HOME}
sudo chmod 775 --recursive $GIT_DIR
sudo chmod 775 --recursive $GIT_WORK_TREE

git config --global core.autocrlf input

cd $GIT_DIR

git clone git@github.com/DaveCheez/PyShop.git . --bare
git --work-tree=$GIT_WORK_TREE --git-dir=${GIT_DIR} checkout -f
python -m venv $VENVBIN
cd $GIT_WORK_TREE

${VENVBIN}/python3 -m pip install -r /$GIT_WORK_TREE/requirements.txt

cat <<EOT >> /var/repo/"$projectgit"/hooks/post-receive
git --work-tree=${GIT_WORK_TREE} --git-dir=${GIT_DIR} checkout -f

${VENVBIN}/python3 -m pip install -r /$GIT_WORK_TREE/requirements.txt

supervisorctl reread
supervisorctl update
EOT

chmod +x ${GIT_DIR}/hooks/post-receive

exit 0

