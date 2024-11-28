import 'package:flutter/material.dart';

class TelaOpcao extends StatelessWidget {
  const TelaOpcao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha a Tela'),
        backgroundColor: const Color(0xFF3C8DBC), // Cor de fundo do AppBar
        elevation: 5,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Selecione uma das opções abaixo:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3C8DBC), // Cor do texto
                  fontFamily: 'RedHatDisplay', // Definindo a fonte
                ),
              ),
              const SizedBox(height: 40),
              _buildOptionButton(
                context,
                'Ir para Tela Cheia',
                '/monitor',
                const Color(0xFF00A65A), // Cor do botão
              ),
              const SizedBox(height: 20),
              _buildOptionButton(
                context,
                'Ir para Tela do Mapa',
                '/map',
                const Color(0xFF00A65A), // Cor do botão
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, String text, String route, Color color) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);  // Redireciona para a tela
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Cor do fundo do botão
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Borda arredondada
        ),
        elevation: 5, // Sombra do botão
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'RedHatDisplay', // Definindo a fonte para os botões
        ),
      ),
      child: Text(text),
    );
  }
}
