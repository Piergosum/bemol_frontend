import 'package:bemol_frontend/app/services/repository.dart';
import 'package:bemol_frontend/app/storage/models/user.dart';
import 'package:flutter/material.dart';

class UserListScreenController extends ChangeNotifier {
  String _repositoryResponseMessage = '';

  String get repositoryResponseMessage => _repositoryResponseMessage;

  final Repository _repository = Repository();

  final List<User> usersList = [];

  Future<String> requestUserList() async {
    String request = await _repository.requestUsersList();
    if (request == 'success') {
      List<dynamic> userMapList = _repository.requestResponse!.data['data'];
      for (dynamic user in userMapList) {
        usersList.add(
          User.fromJson(user),
        );
      }
      return 'success';
    } else {
      _repositoryResponseMessage = _repository.errorMessageDescription!;
      return 'fail';
    }
  }
}
