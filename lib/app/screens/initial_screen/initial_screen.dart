import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(child: SizedBox()),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                Expanded(
                  flex: 3,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Hero(
                            tag: 'bemol logo',
                            child: Image.asset(
                              'images/bemol.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          left: 400,
                          child: ClipPath(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            clipper: OvalLeftBorderClipper(),
                            child: Container(
                              color: const Color.fromRGBO(203, 62, 69, 1),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          left: 400,
                          child: Row(
                            children: [
                              const Expanded(child: SizedBox()),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                Navigator.pushNamed(
                                                    context, '/cadastro');
                                              },
                                              child: const Text(
                                                  'Cadastrar usuário',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                Navigator.pushNamed(context,
                                                    '/listagem-usuarios');
                                              },
                                              child: const Text(
                                                  'Listar usuários',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
