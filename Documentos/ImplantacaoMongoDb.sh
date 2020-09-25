####################### Atualizações e verificações iniciais #######################
# Verificar e realizar atualizações dos pacotes do sistema
sudo apt-get update

# Verificar e realizar atualizações de novos pacotes do sistema
sudo apt-get upgrade

####################### Atualização do python #######################

# Instalar a versão mais recente do Python (3.8)
sudo apt-get install python3.8-dev python3.8

# Instalação do PIP
sudo apt install python3-pip

#Verificação da versão do Python
python3 --version

#Verificação da versão do PIP
pip3 --version

####################### Instalação do Ansible #######################

# Instalação do Ansible
sudo apt install ansible

# Verificação da versão instalada
ansible --version

####################### Instalação do docker #######################

# Remover Versões antigas do docker caso exista
sudo apt-get remove docker docker-engine docker.io containerd runc

# instalar os pacotes para permitir que os protocolos HTTPS sejam utilizados quando necessário:
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# Acidionar GPG key oficial do Docker:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Verificar GPG key
sudo apt-key fingerprint 0EBFCD88

# Adicionando um repositório
sudo add-apt-repository \
   "deb [arch=arm64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

#atualizar os pacotes
sudo apt-get update

#instalar a versão mais recente do docker e containerd
sudo apt-get install docker-ce docker-ce-cli containerd.io

#Verificar se o Docker foi instalado corretamente rodando a imagem hello-world
sudo docker run hello-world

# Instalação do docker compose
sudo apt install docker-compose

####################### Configuração o serviço SSH #######################

# atualizar os pacotes
sudo apt update

# Criação de chave utilizando o ssh-keygen
ssh-keygen

# Instalar o openssh-server
sudo apt install openssh-server -y

# Checagem do SSH
sudo systemctl status sshd

# Configurar o firewall para permitir acesso SSH
sudo ufw allow ssh

# Criar o usuário ansible
sudo adduser ansible

# Configurar acesso sudo sem senha para o usuário ansible
echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible

# Verificar o endereço IP do host Ansible
hostname -I

# Copiando SSH public key do host Ansible
ssh-copy-id ansible@192.168.0.12

# disable password-based login for the ansible user
# sudo usermod -L ansible

####################### Testando Ansible #######################

# Testando acesso via SSH
ssh ansible@192.168.0.12

#Criando diretório do projeto
mkdir ~/projetoMongo

#Acessando diretório do projeto
cd ~/projetoMongo

# Configurar arquivo hosts com o ip utilizado - 192.168.0.12
nano hosts

# Pingando o ansible
ansible all -i ./hosts -u ansible -m ping

# Testanto o host
ansible all -i ./hosts -u ansible -m shell -a 'echo "$(hostname) - $(hostname -I)"'


### Caso a implantação do projeto seja feita utilizando playbooks, basta executar os comandos abaixo ###

####################### Comandos para rodar as playbooks #######################

# Executar playbook PreparaAmbienteInicial
ansible-playbook -i ./hosts -u ansible -b playbookPreparaAmbienteInicial.yml

# Executar playbook InstalaPacotesPython
ansible-playbook -i ./hosts -u ansible -b playbookInstalaPacotesPython.yml

# Executar playbook InstalaDocker
ansible-playbook -i ./hosts -u ansible -b playbookInstalaDocker.yml

# Executar playbook PreparaAmbienteMongo
ansible-playbook -i ./hosts -u ansible -b playbookPreparaAmbienteMongo.yml

# Caso o servidor seja reiniciado será necessário iniciar a imagem do Mongo e MongoDB através do playbook IniciarMongoDb -
ansible-playbook -i ./hosts -u ansible -b playbookIniciarMongoDb.yml
