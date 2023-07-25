class FormValidator {
  String? validate(String value, String type) {
    if (value.isEmpty) {
      return '$type obrigatório';
    } else {
      if ((type == 'Data de Nascimento' && value.length < 10) ||
          (type == 'CEP' && value.length < 10)) {
        return 'quantidade de caracteres insuficiente';
      }
      return null;
    }
  }
}
