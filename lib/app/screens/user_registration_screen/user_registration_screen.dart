import 'package:bemol_frontend/app/screens/shared_widgets/response_popup.dart';
import 'package:bemol_frontend/app/screens/user_registration_screen/widgets/custom_text_form_field.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller/user_registration_screen_controller.dart.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreen();
}

class _UserRegistrationScreen extends State<UserRegistrationScreen> {
  late UserRegistrationScreenController _userRegistrationScreenController;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final _userRegistrationFormKey = GlobalKey<FormState>();
  final ResponsePopup _responsePopup = ResponsePopup();

  @override
  void initState() {
    super.initState();
    _userRegistrationScreenController = UserRegistrationScreenController();
  }

  @override
  void dispose() {
    super.dispose();
    _userRegistrationScreenController.dispose();
    _userNameController.dispose();
    _birthDayController.dispose();
    _adressController.dispose();
    _cepController.dispose();
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
                  'Cadastro de usuário',
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
                  child: Column(
                    children: [
                      Form(
                        key: _userRegistrationFormKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              label: 'Nome Completo',
                              controller: _userNameController,
                              validator: _userRegistrationScreenController
                                  .formValidator.validate,
                              inputFormatters: const [],
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextFormField(
                              label: 'Data de Nascimento',
                              controller: _birthDayController,
                              validator: _userRegistrationScreenController
                                  .formValidator.validate,
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
                              validator: _userRegistrationScreenController
                                  .formValidator.validate,
                              inputFormatters: const [],
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextFormField(
                              label: 'CEP',
                              controller: _cepController,
                              validator: _userRegistrationScreenController
                                  .formValidator.validate,
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
                      ValueListenableBuilder(
                        valueListenable:
                            _userRegistrationScreenController.registerLoading,
                        builder: (context, value, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(203, 62, 69, 1),
                                    ),
                                    onPressed: () async {
                                      if (_userRegistrationFormKey.currentState!
                                          .validate()) {
                                        String request =
                                            await _userRegistrationScreenController
                                                .registerUser(
                                                    _userNameController.text,
                                                    _birthDayController.text,
                                                    _adressController.text,
                                                    _cepController.text);

                                        if (context.mounted) {
                                          return _responsePopup.showPopup(
                                              context,
                                              _userRegistrationScreenController
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
                                            'Cadastrar',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
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
