import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/login_screen.dart';
import 'screens/cheia_monitor_screen.dart';
import 'screens/register_screen.dart';
import 'screens/map_screen.dart';
import 'screens/tela_opcao.dart';  // Importando a tela de opções

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REWS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black, fontSize: 18), // Substituído bodyText1 por bodyLarge
          headlineMedium: TextStyle(  // Substituído headline6 por headlineMedium
            fontSize: 30, 
            fontWeight: FontWeight.bold, 
            color: Color(0xFF3C8DBC), // Cor personalizada
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF00A65A), // Cor do botão
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/monitor': (context) => CheiaMonitorScreen(),
        '/register': (context) => RegisterScreen(),
        '/map': (context) => MapScreen(),
        '/options': (context) => const TelaOpcao(),
      },
      // Configuração de Localizações
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // Adicionado para suportar localizações do Cupertino
      ],
      supportedLocales: [
        Locale('pt', 'BR'),  // Português do Brasil
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REWS - Login'),
        backgroundColor: Color(0xFF3C8DBC), // Cor personalizada
        centerTitle: true,
        elevation: 5,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Bem-vindo ao REWS!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3C8DBC), // Cor personalizada
                ),
              ),
              const SizedBox(height: 40),
              _buildLoginForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'E-mail',
            prefixIcon: Icon(Icons.email, color: Color(0xFF3C8DBC)), // Cor personalizada
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF3C8DBC)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF3C8DBC), width: 2),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Senha',
            prefixIcon: Icon(Icons.lock, color: Color(0xFF3C8DBC)), // Cor personalizada
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF3C8DBC)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF3C8DBC), width: 2),
            ),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            // Redirecionar para a tela de opções após o login
            Navigator.pushNamed(context, '/options');
          },
          child: const Text('Entrar'),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register'); // Navega para tela de cadastro
          },
          child: const Text(
            'Não tem uma conta? Cadastre-se',
            style: TextStyle(color: Color(0xFF3C8DBC)), // Cor personalizada
          ),
        ),
      ],
    );
  }
}
