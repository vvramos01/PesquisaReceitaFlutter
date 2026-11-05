# Atividade 02 - Criando campos de pesquisa (Flutter)
App Flutter com campo rotulado para pesquisar receitas pelo nome.

# Funcionalidades
Campo "Nome da receita" com botão Pesquisar (ou tecla de busca do teclado) e botão Limpar
Consulta vazia ou só com espaços é recusada, sem iniciar pesquisa
A mensagem de erro explica como corrigir a entrada
Espaços nas pontas são removidos e espaços repetidos viram um só
Consulta válida mostra "Pesquisando por: “termo”" e resultados provisórios
O texto continua no campo para corrigir e pesquisar de novo

# Como executar
Este repositório contém só o código-fonte. Na primeira vez, gere as pastas de plataforma:

flutter create .
flutter pub get
flutter run
Para rodar os testes: flutter test

# Estrutura
lib/main.dart - tela, validação e pesquisa (_pesquisar() usa resultados provisórios)
test/widget_test.dart - testes dos casos vazio, só espaços e termo válido
