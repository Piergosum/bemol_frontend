import 'package:bemol_frontend/app/services/http_client.dart';
import 'package:bemol_frontend/app/storage/config.dart';
import 'package:bemol_frontend/app/storage/models/user.dart';
import 'package:dio/dio.dart';

class Repository {
  final String _url = Config.apiUrl;
  String? _errorMessageDescription;
  Response? _requestResponse;

  final CustomHttpClient _customHttpClient = CustomHttpClient(
    client: Dio(
      BaseOptions(connectTimeout: 8000, receiveTimeout: 8000),
    ),
  );

  Response? get requestResponse => _requestResponse;
  String? get errorMessageDescription => _errorMessageDescription;

  Future<String> requestGet(
      {required String? endPoint,
      Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _customHttpClient.client
          .get(_url + endPoint!, queryParameters: queryParameters!);
      _requestResponse = response;
      return 'success';
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout) {
        _errorMessageDescription = 'Conexão indisponível';
        return 'no connection';
      } else {
        _errorMessageDescription = e.response!.data['message'];
        return 'Não foi possível realizar a operação. Tente novamente';
      }
    }
  }

  Future<String> requestPost({required String? endPoint, dynamic data}) async {
    try {
      Response response =
          await _customHttpClient.client.post(_url + endPoint!, data: data!);
      _requestResponse = response;
      return 'success';
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout) {
        _errorMessageDescription = 'Conexão indisponível';
        return 'no connection';
      } else {
        _errorMessageDescription = e.response!.data['message'];
        return 'Não foi possível realizar a operação. Tente novamente';
      }
    }
  }

  Future<String> requestPut({required String? endPoint, dynamic data}) async {
    try {
      Response response =
          await _customHttpClient.client.put(_url + endPoint!, data: data!);
      _requestResponse = response;
      return 'success';
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout) {
        _errorMessageDescription = 'Conexão indisponível';
        return 'no connection';
      } else {
        _errorMessageDescription = e.response!.data['message'];
        return 'Não foi possível realizar a operação. Tente novamente';
      }
    }
  }

  Future<String> requestDelete(
      {required String? endPoint, dynamic data}) async {
    try {
      Response response =
          await _customHttpClient.client.delete(_url + endPoint!, data: data!);
      _requestResponse = response;
      return 'success';
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout) {
        _errorMessageDescription = 'Conexão indisponível';
        return 'no connection';
      } else {
        _errorMessageDescription = e.response!.data['message'];
        return 'Não foi possível realizar a operação. Tente novamente';
      }
    }
  }

  Future<String> registerUser(User user) async {
    String result = await requestPost(endPoint: 'user', data: {
      'name': user.name,
      'cep': user.cep,
      'address': user.address,
      'dateOfBirth': user.dateOfBirth,
    });

    return result;
  }

  Future<String> requestUsersList() async {
    String result = await requestGet(endPoint: 'user', queryParameters: {}); //
    return result;
  }

  Future<String> requestUserData(String id) async {
    String result =
        await requestGet(endPoint: 'user/$id', queryParameters: {}); //
    return result;
  }

  Future<String> requestUpdateUser(User user) async {
    String result = await requestPut(endPoint: 'user/${user.id}', data: {
      'name': user.name,
      'cep': user.cep,
      'address': user.address,
      'dateOfBirth': user.dateOfBirth,
    }); //
    return result;
  }
}
