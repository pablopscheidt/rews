import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheiaMonitorScreen extends StatefulWidget {
  @override
  _CheiaMonitorScreenState createState() => _CheiaMonitorScreenState();
}

class _CheiaMonitorScreenState extends State<CheiaMonitorScreen> {
  double nivelRio = 0.0;

  Future<void> _fetchNivelRio() async {
    final response = await http.get(Uri.parse('http://localhost:3000/nivelRio'));
    final data = json.decode(response.body);
    setState(() {
      nivelRio = data['main']['temp'];
    });
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
        child: Text("Nível do rio: $nivelRio"),
      ),
    );
  }
}
