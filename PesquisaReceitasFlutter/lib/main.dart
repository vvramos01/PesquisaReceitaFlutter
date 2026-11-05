import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pesquisa de receitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F5D50)),
        useMaterial3: true,
      ),
      home: const PesquisaReceitasPage(),
    );
  }
}

class PesquisaReceitasPage extends StatefulWidget {
  const PesquisaReceitasPage({super.key});

  @override
  State<PesquisaReceitasPage> createState() => _PesquisaReceitasPageState();
}

class _PesquisaReceitasPageState extends State<PesquisaReceitasPage> {
  static const String msgVazio =
      'O campo está vazio. Digite o nome da receita, por exemplo: bolo de cenoura.';
  static const String msgSoEspacos =
      'A pesquisa contém apenas espaços. Digite o nome da receita, por exemplo: bolo de cenoura.';

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();

  String? _erro;
  String? _termo;
  List<String> _resultados = [];

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  /// Remove espaços nas pontas e reduz espaços repetidos a um só.
  String _normalizar(String texto) =>
      texto.trim().replaceAll(RegExp(r'\s+'), ' ');

  void _pesquisar() {
    final bruto = _controller.text;
    final termo = _normalizar(bruto);

    // Consulta inválida: não inicia pesquisa.
    if (termo.isEmpty) {
      setState(() {
        _erro = bruto.isEmpty ? msgVazio : msgSoEspacos;
        _termo = null;
        _resultados = [];
      });
      _focus.requestFocus();
      return;
    }

    // Consulta válida: mostra o termo tratado e permite corrigir/repetir.
    _controller.value = TextEditingValue(
      text: termo,
      selection: TextSelection.collapsed(offset: termo.length),
    );
    setState(() {
      _erro = null;
      _termo = termo;
      // Resultados provisórios; substituir por busca real depois.
      _resultados = [
        '$termo - versão clássica',
        '$termo - versão rápida',
      ];
    });
  }

  void _limpar() {
    _controller.clear();
    setState(() {
      _erro = null;
      _termo = null;
      _resultados = [];
    });
    _focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Pesquisar receitas')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controller,
                focusNode: _focus,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _pesquisar(),
                onChanged: (_) {
                  if (_erro != null) setState(() => _erro = null);
                },
                decoration: InputDecoration(
                  labelText: 'Nome da receita',
                  hintText: 'Ex.: bolo de cenoura',
                  helperText:
                      'Use ao menos uma letra ou número. Espaços extras são ignorados.',
                  errorText: _erro,
                  errorMaxLines: 3,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.restaurant_menu),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _pesquisar,
                      icon: const Icon(Icons.search),
                      label: const Text('Pesquisar'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: _limpar,
                    child: const Text('Limpar'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_termo != null)
                Semantics(
                  liveRegion: true,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cores.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Pesquisando por: “$_termo”',
                      style: TextStyle(color: cores.onPrimaryContainer),
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _resultados.length,
                  itemBuilder: (context, i) => Card(
                    child: ListTile(
                      title: Text(_resultados[i]),
                      subtitle: const Text('Resultado provisório'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
