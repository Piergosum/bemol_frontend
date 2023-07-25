import 'package:bemol_frontend/app/routes.dart';
import 'package:flutter/material.dart';

class BemolApp extends StatelessWidget {
  const BemolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(42, 43, 96, 1)),
        useMaterial3: true,
      ),
      routes: Routes.routes,
      initialRoute: '/pagina-inicial',
    );
  }
}
