import 'package:bemol_frontend/app/screens/form_validator.dart';
import 'package:bemol_frontend/app/services/repository.dart';
import 'package:bemol_frontend/app/storage/models/user.dart';
import 'package:flutter/material.dart';

class UserDataScreenController extends ChangeNotifier {
  final ValueNotifier<bool> _fetchUserDataLoading = ValueNotifier(false);
  final ValueNotifier<bool> _editEnabled = ValueNotifier(false);
  final ValueNotifier<bool> _registerLoading = ValueNotifier(false);

  String _repositoryResponseMessage = '';

  User? user;

  final FormValidator _formValidator = FormValidator();

  final Repository _repository = Repository();

  ValueNotifier<bool> get fetchUserDataLoading => _fetchUserDataLoading;

  ValueNotifier<bool> get editEnabled => _editEnabled;

  ValueNotifier<bool> get registerLoading => _registerLoading;

  String get repositoryResponseMessage => _repositoryResponseMessage;

  FormValidator get formValidator => _formValidator;

  Future<String> requestUserData(String id) async {
    _fetchUserDataLoading.value = true;
    String request = await _repository.requestUserData(id);
    if (request == 'success') {
      dynamic userMap = _repository.requestResponse!.data['data'];
      user = User.fromJson(userMap);
      _fetchUserDataLoading.value = false;
      return 'success';
    } else {
      _repositoryResponseMessage = _repository.errorMessageDescription!;
      _registerLoading.value = false;
      return 'fail';
    }
  }

  void enableEdit() {
    _editEnabled.value = _editEnabled.value ? false : true;
  }

  Future<String> requestUpdateUser(String id, String userName,
      String dateOfBirth, String address, String cep) async {
    _registerLoading.value = true;
    String convertedDateOfBirth =
        '${dateOfBirth.substring(6, 10)}-${dateOfBirth.substring(3, 5)}-${dateOfBirth.substring(0, 2)}';
    String convertedCep = cep.replaceAll('.', '').replaceAll('-', '');
    User user = User(
        id: id,
        name: userName,
        dateOfBirth: convertedDateOfBirth,
        address: address,
        cep: convertedCep);
    String request = await _repository.requestUpdateUser(user);
    if (request == 'success') {
      _repositoryResponseMessage = 'Alteração realizada com sucesso!';
      _registerLoading.value = false;
      return 'success';
    } else {
      _repositoryResponseMessage = _repository.errorMessageDescription!;
      _registerLoading.value = false;
      return 'fail';
    }
  }
}
