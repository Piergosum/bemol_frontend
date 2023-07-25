import 'package:bemol_frontend/app/screens/form_validator.dart';
import 'package:bemol_frontend/app/services/repository.dart';
import 'package:bemol_frontend/app/storage/models/user.dart';
import 'package:flutter/material.dart';

class UserRegistrationScreenController extends ChangeNotifier {
  final ValueNotifier<bool> _registerLoading = ValueNotifier(false);

  String _repositoryResponseMessage = '';

  final Repository _repository = Repository();

  final FormValidator _formValidator = FormValidator();

  ValueNotifier<bool> get registerLoading => _registerLoading;

  String get repositoryResponseMessage => _repositoryResponseMessage;

  FormValidator get formValidator => _formValidator;

  Future<String> registerUser(
      String userName, String dateOfBirth, String address, String cep) async {
    _registerLoading.value = true;
    String convertedDateOfBirth =
        '${dateOfBirth.substring(6, 10)}-${dateOfBirth.substring(3, 5)}-${dateOfBirth.substring(0, 2)}';
    String convertedCep = cep.replaceAll('.', '').replaceAll('-', '');
    User user = User(
        name: userName,
        dateOfBirth: convertedDateOfBirth,
        address: address,
        cep: convertedCep);
    String request = await _repository.registerUser(user);
    if (request == 'success') {
      _repositoryResponseMessage = 'Usuário cadastrado com sucesso!';
      _registerLoading.value = false;
      return 'success';
    } else {
      _repositoryResponseMessage = _repository.errorMessageDescription!;
      _registerLoading.value = false;
      return 'fail';
    }
  }
}
