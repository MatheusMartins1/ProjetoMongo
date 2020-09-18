REM Direcionando para o Diretório
cd D:\Users\Matheus\Documents\3 - Acadêmico\OneDrive - al.infnet.edu.br\1 - INFNET\6 - Arquitetura de Infraestrutura de Aplicações\01 - Projeto em Arquitetura e Infraestrutura de Aplicações\ProjetoMongo

REM Iniciando diretório
git init 

REM Status do diretório
git status

REM Conectando à origin
git remote add origin https://github.com/MatheusMartins1/ProjetoMongo

REM Testando conexão
git remote -v

REM Primeiro commit
git commit -m "First Commit"

REM Push repository into origin
git push origin master

REM Remoção de uma pasta sem uso

git config --global user.email "matheus.martins@al.infnet.edu.br"
git config --global user.name "Matheus Martins"

git add .
git pull origin master
git commit -am "Init commit"
git push origin master

git checkout -b ProjetoMongo

