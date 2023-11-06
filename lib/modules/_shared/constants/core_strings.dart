class CoreStrings {
  static Configs configs = const Configs();
  static Errors errors = const Errors();
  static Actions actions = const Actions();
  static TextFields textField = const TextFields();
  static Dates dates = const Dates();
  static Biometrics biometrics = const Biometrics();
}

class Configs {
  const Configs();

  String get configsBoxName => 'appConfigs';

  String get usersBoxName => 'appUsers';

  String get isDarkTheme => 'isDarkTheme';

  String get isFingerprintEnabled => 'isFingerprintEnabled';

  String get isAppLaunchingFirstTime => 'isAppLaunchingFirstTime';

  String get currentUser => 'currentUser';

  String get isFirstLogin => 'isFirstLogin';

  static String eyeVectorPath(bool isClosed) => isClosed ? 'assets/vectors/ic_eye_closed.svg' : 'assets/vectors/ic_eye_open.svg';
}

class Actions {
  const Actions();

  String get ok => 'Ok';

  String get yes => 'Sim';

  String get no => 'Não';

  String get cancel => 'Cancelar';

  String get skip => 'Pular';

  String get next => 'Próximo';

  String get confirm => 'Confirmar';

  String get save => 'Salvar';

  String get tryAgain => 'Tentar novamente';

  String get send => 'Enviar';

  String get search => 'Pesquisar';

  String get delete => 'Excluir';
}

class Errors {
  const Errors();

  String get title => 'Desculpe!';

  String get unknown => 'Erro desconhecido, não foi possível completar sua requisição.';

  String get withoutConnection => 'Rede indisponível.';

  String get timeout => 'Erro inesperado, por favor tente novamente.';

  String get invalidData => 'Dados Inválidos';
}

class TextFields {
  const TextFields();

  String invalid(String fieldName) {
    return 'O campo $fieldName está inválido.';
  }

  String empty(String fieldName) {
    return 'O campo $fieldName não pode ser vazio.';
  }

  String get notSameEmail => 'Os e-mails não conferem.';

  String lessThanError(int length) => 'O campo não pode ter menos que $length caracteres';

  String regex(String fieldName) => '$fieldName não atende aos critérios exigidos.';

  String password(String field, int count) =>
      'A $field não pode conter menos de $count caracteres.';
}

class Dates {
  const Dates();

  String get today => 'Hoje';

  String get yesterday => 'Ontem';
}

class Biometrics {
  const Biometrics();

  String get modalTitle => 'Acesse com sua digital';

  String get noFingerprintSet => 'Não existem digitais configuradas';
}
