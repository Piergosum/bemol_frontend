import 'package:bemol_frontend/app/screens/users_list_screen/controller/users_list_screen_controller.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late UserListScreenController _userListScreenController;

  @override
  void initState() {
    super.initState();
    _userListScreenController = UserListScreenController();
  }

  @override
  void dispose() {
    super.dispose();
    _userListScreenController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 180,
          backgroundColor: const Color.fromRGBO(42, 43, 96, 1),
          title: Row(
            children: [
              Hero(
                tag: 'bemol logo',
                child: Image.asset(
                  'images/bemol-centered.png',
                  fit: BoxFit.cover,
                  height: 180,
                ),
              ),
              const Expanded(
                child: Text(
                  'Listagem de usuários',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      FutureBuilder(
                        future: _userListScreenController.requestUserList(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (_userListScreenController.usersList.isEmpty) {
                              return const Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                    ),
                                    Text(
                                      'Nenhum usuário registrado',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _userListScreenController
                                      .usersList.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: 0,
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: MaterialButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/dados-usuario',
                                                arguments:
                                                    _userListScreenController
                                                        .usersList[index].id);
                                          },
                                          child: SizedBox(
                                            height: 50,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                _userListScreenController
                                                    .usersList[index].name,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider();
                                  },
                                ),
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
