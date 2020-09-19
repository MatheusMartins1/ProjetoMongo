REM Direcionando para o Diretório
cd D:\Users\Matheus\Documents\3 - Acadêmico\OneDrive - al.infnet.edu.br\1 - INFNET\6 - Arquitetura de Infraestrutura de Aplicações\01 - Projeto em Arquitetura e Infraestrutura de Aplicações\ProjetoMongo

REM Iniciando diretório
git init 
git add .

REM Status do diretório
git status

REM Conectando à origin
git remote add origin https://github.com/MatheusMartins1/ProjetoMongo

REM Testando conexão
git remote -v

REM Primeiro commit
git commit -m "First Commit"

REM Pull + Merge
git pull origin master --allow-unrelated-histories

REM Push repository into origin
git push origin master

REM As credenciais para publicação foram realizadas através o aplicativo do GitHub para Windows

