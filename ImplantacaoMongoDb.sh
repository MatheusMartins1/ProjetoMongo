####################### Atualizações e verificações iniciais #######################
sudo apt update
sudo apt update

####################### Atualização do python #######################
sudo apt-get update
sudo apt-get upgrade

sudo apt-get install python3.8-dev python3.8

sudo apt install python3-pip

python3 --version

pip3 --version

####################### Instalação do Ansible #######################

sudo apt install ansible

ansible --version


####################### Instalação do docker #######################

# Uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update

# Update the apt package index and install packages to allow apt to use a repository over HTTPS:
sudo apt-get install
sudo apt-transport-https
sudo ca-certificates
sudo curl
sudo gnupg-agent
sudo software-properties-common

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -


####################### Configuração o serviço SSH #######################

# Criação de chave utilizando o ssh-keygen
ssh-keygen

# Configurando o Host para as automatizações ansible
sudo apt update

sudo apt install openssh-server -y

# Checagem do SSH
sudo systemctl status sshd

# configure the firewall to allow SSH access
sudo ufw allow ssh

# create an ansible user
sudo adduser ansible

# configure password-less sudo access to the ansible user
echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible

# find the IP address of the Ansible host
hostname -I

# copy the SSH public key to the Ansible host
ssh-copy-id ansible@192.168.0.12

# disable password-based login for the ansible user
sudo usermod -L ansible



####################### Testando Ansible #######################

# you should be able to SSH into the ansible host 
ssh ansible@192.168.0.12

mkdir ~/projetoMongo

cd ~/projetoMongo

nano hosts

ansible all -i ./hosts -u ansible -m ping

ansible all -i ./hosts -u ansible -m shell -a 'echo "$(hostname) - $(hostname -I)"'


####################### Instalação do MongoDB #######################

ansible-playbook -i ./hosts -u ansible -b preparaAmbiente.yml

ansible-playbook -i ./hosts -u ansible -b playbookMongo.yml

####################### Iniciar MongoDB #######################
ansible-playbook -i ./hosts -u ansible -b playbookIniciarMongoDb.yml

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS               NAMES
331bce131351        mongo-express       "tini -- /docker-ent…"   36 hours ago        Exited (143) 35 hours ago                       projetomongo_mongo-express_1
17d1a4f074b8        mongo               "docker-entrypoint.s…"   36 hours ago        Exited (0) 35 hours ago                         projetomongo_mongo_1
