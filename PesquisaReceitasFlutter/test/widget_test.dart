import 'package:flutter_test/flutter_test.dart';
import 'package:pesquisa_receitas/main.dart';

void main() {
  testWidgets('recusa consulta vazia', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Pesquisar'));
    await tester.pump();

    expect(find.textContaining('O campo está vazio'), findsOneWidget);
    expect(find.textContaining('Pesquisando por'), findsNothing);
  });

  testWidgets('recusa consulta só com espaços', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byType(TextField), '    ');
    await tester.tap(find.text('Pesquisar'));
    await tester.pump();

    expect(find.textContaining('apenas espaços'), findsOneWidget);
    expect(find.textContaining('Pesquisando por'), findsNothing);
  });

  testWidgets('trata espaços e mostra o termo válido', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byType(TextField), '  bolo   de  cenoura ');
    await tester.tap(find.text('Pesquisar'));
    await tester.pump();

    expect(find.text('Pesquisando por: “bolo de cenoura”'), findsOneWidget);
  });
}
