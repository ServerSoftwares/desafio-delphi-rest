Este é um aplicativo desenvolvido em Delphi versão 11 que permite a consulta de CEPs utilizando a API pública de https://brasilapi.com.br/docs

Funcionalidades
Consulta de CEP por meio da API do ViaCEP;
Consulta primeiramente o banco de dados;
Exibição do endereço completo correspondente ao CEP consultado;
Gravação em banco de dados do resultado quando a consulta via API obter sucesso;
Método de busca automática configurável;

Requisitos do sistema
Sistema operacional Windows;
Delphi XE ou superior;
Acesso à internet para realizar as consultas na API do ViaCEP.

Instalação
NECESSARIA CONFIGURAÇÃO DO BANCO DE DADOS;
Clone ou faça o download deste repositório;
Abra o projeto no Delphi;
Compile o projeto para gerar o arquivo executável;
Execute o arquivo gerado para utilizar o aplicativo.

Configuração Banco de Dados
Neste projeto foi optado por utilizar conexão ADO criada em tempo de execução;
Na pasta chamada configuração que acompanha o executavel, acompanha drivers necessários para sistema 32 e 64 bits;
No windows abrir, ODBC data sources conforme seu sistema;
Verificar se existe o metodo POSTGRESQL35W, caso não haja, é necessário criar a conexão em DSN DE USUARIO > ADICIONAR > Preencher com o database do seu postgres;
Ao testar a conexão se funcionou, basta ir para o executável, rodá-lo e configurar manualmente o banco dentro da aplicação.


Uso
Abra o aplicativo;
Insira o CEP que deseja consultar no campo correspondente;
Clique no botão "Consultar";
O endereço correspondente ao CEP será exibido na tela;

Contribuição
Contribuições são bem-vindas! Se você encontrou um problema ou tem uma sugestão de melhoria, abra uma issue neste repositório ou envie um pull request.

Licença
##