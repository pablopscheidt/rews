import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheiaMonitorScreen extends StatefulWidget {
  @override
  _CheiaMonitorScreenState createState() => _CheiaMonitorScreenState();
}

class _CheiaMonitorScreenState extends State<CheiaMonitorScreen> {
  double nivelRio = 0.0;
  bool isLoading = true;  // Variável para controlar o estado de carregamento.
  String errorMessage = '';  // Para exibir mensagens de erro caso necessário.

Future<void> _fetchNivelRio() async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/nivelRio'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        nivelRio = data['nivel'] ?? 0.0; // Atualize com o campo correto do JSON
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = 'Erro ao carregar dados do nível do rio';
      });
    }
  } catch (e) {
    setState(() {
      isLoading = false;
      errorMessage = 'Erro de conexão: $e';
    });
  }
}



  @override
  void initState() {
    super.initState();
    _fetchNivelRio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Monitoramento de Cheias")),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : errorMessage.isNotEmpty
                ? Text(errorMessage)
                : Text("Nível do rio: $nivelRio m"),
      ),
    );
  }
}
