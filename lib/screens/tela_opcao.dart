import 'package:flutter/material.dart';
import 'cheia_monitor_screen.dart';  // Corrija o caminho para a tela CheiaScreen
import 'map_screen.dart';    // Importe a tela MapScreen

class TelaOpcao extends StatelessWidget {
  const TelaOpcao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escolha a Tela')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Redireciona para a tela CheiaScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheiaMonitorScreen()),
                );
              },
              child: const Text('Ir para Tela Cheia'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Redireciona para a tela MapScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapScreen()),
                );
              },
              child: const Text('Ir para Tela do Mapa'),
            ),
          ],
        ),
      ),
    );
  }
}
