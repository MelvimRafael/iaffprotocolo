import 'package:appiatfexpor/telas/cadastros.dart';
import 'package:appiatfexpor/telas/calendario.dart';
import 'package:appiatfexpor/telas/home_page.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IATF PROTOCOL',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/cadastro': (context) => CadastrosPage(),
        '/calendario': (context) => CalendarioPage(),
      },
    );

    // ignore: dead_code
    const HomePage();
  }
}
