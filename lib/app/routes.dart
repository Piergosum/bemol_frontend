import 'package:bemol_frontend/app/screens/initial_screen/initial_screen.dart';
import 'package:bemol_frontend/app/screens/user_data_screen/user_data_screen.dart';
import 'package:bemol_frontend/app/screens/user_registration_screen/user_registration_screen.dart';
import 'package:bemol_frontend/app/screens/users_list_screen/users_list_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    '/pagina-inicial': (_) => const InitialScreen(),
    '/cadastro': (_) => const UserRegistrationScreen(),
    '/listagem-usuarios': (_) => const UserListScreen(),
    '/dados-usuario': (_) => const UserDataScreen()
    //'/quem-somos': (_) => const AboutPratexScreen(),
  };
}
