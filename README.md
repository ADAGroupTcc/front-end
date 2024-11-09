Intruções para instalação e testes

Opção 1 (Através de arquivo executável):
1. Acesse a página do repositório
Abra o link para o repositório do projeto no GitHub: https://github.com/ADAGroupTcc
2. Navegue até a seção de Releases
Na página inicial do repositório, localize a seção Releases (geralmente, fica na barra lateral direita ou próxima do topo da página).
Clique para acessar a lista de lançamentos.
3. Faça o download do executável
Na lista de Releases, localize a versão mais recente do aplicativo (normalmente a última no topo).
Clique na release, e, na página aberta, procure pelo arquivo executável do app (.apk para Android, .exe para Windows, etc.).
Baixe o arquivo clicando no link disponível.
4. Instalar o app 
Para Android: se for um arquivo .apk, basta transferi-lo para um dispositivo Android e permitir a instalação de fontes desconhecidas, em Configurações > Segurança.
Opção 2 (Debugando o projeto):
Pré-requisitos
1.	Flutter SDK instalado em seu computador.
2.	Dispositivo Android configurado para desenvolvimento (com depuração USB ativada).
3.	Cabo USB para conectar o dispositivo ao computador.
4.	Editor de código, como o Visual Studio Code ou Android Studio.
Passo 1: Instale o Flutter SDK
1.	Faça o download do Flutter SDK em flutter.dev.
2.	Extraia o arquivo baixado e configure o caminho do Flutter no ambiente.
•	No Windows, adicione o caminho flutter/bin às variáveis de ambiente.
3.	Verifique a instalação com o comando:
flutter doctor

Esse comando ajuda a verificar se você tem todas as dependências necessárias.
Passo 2: Clone o repositório:
Clone o repositório  de front-end utilizando a branch “entrega” do nosso projeto disponível em: 
https://github.com/ADAGroupTcc/front-end

Para a IDE de sua preferência (Ex.: VSCode, Android Studio)
Passo 3: Ative a Depuração no Dispositivo
Para Android:
1.	Ative Opções do desenvolvedor no dispositivo Android:
•	Vá para Configurações > Sobre o telefone > Número da versão.
•	Toque no Número da versão várias vezes até ver uma mensagem de confirmação.
2.	Em Configurações > Opções do desenvolvedor, ative Depuração USB.
3.	Conecte o dispositivo ao computador com o cabo USB.
Passo 4: Verifique a Conexão com o Dispositivo
1.	No terminal, execute o comando:
flutter devices

Esse comando listará todos os dispositivos conectados. Se o dispositivo não aparecer, verifique as configurações de depuração USB e tente novamente.
Passo 5: Inicie o Aplicativo em Modo de Depuração
1.	Navegue até o diretório do projeto Flutter no terminal.
2.	Para rodar o aplicativo no dispositivo, execute:
flutter run

Isso instalará o aplicativo no dispositivo e o iniciará no modo de depuração. Você poderá ver os logs do aplicativo diretamente no terminal.
No Visual Studio Code:
1.	Abra o projeto Flutter no VS Code.
2.	Conecte o dispositivo e certifique-se de que ele está sendo reconhecido.
3.	Clique na aba de Run and Debug (ou pressione F5) para iniciar a depuração.
4.	Você verá os logs e poderá definir pontos de interrupção (breakpoints).
No Android Studio:
1.	Abra o projeto no Android Studio.
2.	Clique em Run > Run ‘main.dart’ para iniciar o aplicativo no dispositivo conectado.
3.	No console, você verá os logs e poderá definir pontos de interrupção no código para analisar a execução.

Notas:
Estamos disponíveis para responder quaisquer dúvidas relacionadas a instalação e testes do nosso projeto.
