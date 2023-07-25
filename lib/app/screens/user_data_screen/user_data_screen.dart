import 'package:bemol_frontend/app/screens/user_registration_screen/widgets/custom_text_form_field.dart';
import 'package:bemol_frontend/app/storage/models/user.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared_widgets/response_popup.dart';
import 'controller/user_data_screen_controller.dart';

class UserDataScreen extends StatelessWidget {
  const UserDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserDataScreenController userDataScreenController =
        UserDataScreenController();
    final String id = ModalRoute.of(context)!.settings.arguments as String;
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
                  'Dados do usuário',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          const Expanded(child: SizedBox()),
          Expanded(
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: FutureBuilder(
                    future: userDataScreenController.requestUserData(id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.data == 'success') {
                          return UserDataView(
                              user: userDataScreenController.user!);
                        } else {
                          return const Center(
                            child: Text(
                                'Não foi possível carregar os dados. Tente novamente'),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}

class UserDataView extends StatefulWidget {
  const UserDataView({super.key, required this.user});

  final User user;

  @override
  State<UserDataView> createState() => _UserDataView();
}

class _UserDataView extends State<UserDataView> {
  late UserDataScreenController _userDataScreenController;
  late TextEditingController _userNameController;
  late TextEditingController _birthDayController;
  late TextEditingController _adressController;
  late TextEditingController _cepController;
  final _userRegistrationFormKey = GlobalKey<FormState>();
  final ResponsePopup _responsePopup = ResponsePopup();

  @override
  void initState() {
    super.initState();
    _userDataScreenController = UserDataScreenController();
    _userNameController = TextEditingController(text: widget.user.name);
    _birthDayController = TextEditingController(text: widget.user.dateOfBirth);
    _adressController = TextEditingController(text: widget.user.address);
    _cepController = TextEditingController(text: widget.user.cep);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _userDataScreenController.editEnabled,
      builder: (context, value, child) {
        if (!value) {
          return Column(
            children: [
              ListTile(
                title: const Text(
                  'Nome Completo',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(widget.user.name),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text(
                  'Data de Nascimento',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(widget.user.dateOfBirth),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text(
                  'Endereço',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(widget.user.address),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text(
                  'CEP',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(widget.user.cep),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(203, 62, 69, 1),
                        ),
                        onPressed: () async {
                          _userDataScreenController.enableEdit();
                        },
                        child: const Text(
                          'Editar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Form(
                key: _userRegistrationFormKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: 'Nome Completo',
                      controller: _userNameController,
                      validator:
                          _userDataScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      label: 'Data de Nascimento',
                      controller: _birthDayController,
                      validator:
                          _userDataScreenController.formValidator.validate,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter(),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      label: 'Endereço',
                      controller: _adressController,
                      validator:
                          _userDataScreenController.formValidator.validate,
                      inputFormatters: const [],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      label: 'CEP',
                      controller: _cepController,
                      validator:
                          _userDataScreenController.formValidator.validate,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CepInputFormatter()
                      ],
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                        height: 50,
                        child: ValueListenableBuilder(
                          valueListenable:
                              _userDataScreenController.registerLoading,
                          builder: (context, value, child) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(203, 62, 69, 1),
                              ),
                              onPressed: () async {
                                if (_userRegistrationFormKey.currentState!
                                    .validate()) {
                                  String request =
                                      await _userDataScreenController
                                          .requestUpdateUser(
                                              widget.user.id!,
                                              _userNameController.text,
                                              _birthDayController.text,
                                              _adressController.text,
                                              _cepController.text);

                                  if (context.mounted) {
                                    Navigator.popAndPushNamed(
                                        context, '/dados-usuario',
                                        arguments: widget.user.id);
                                    return _responsePopup.showPopup(
                                        context,
                                        _userDataScreenController
                                            .repositoryResponseMessage,
                                        request);
                                  }
                                }
                              },
                              child: value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Salvar',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                            );
                          },
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(203, 62, 69, 1),
                        ),
                        onPressed: () async {
                          _userDataScreenController.enableEdit();
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        }
      },
    );
  }
}
