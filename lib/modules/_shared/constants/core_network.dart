class CoreNetwork {
  static const String baseUrl = '/';
  static const int timeoutLimit = 60;

  // RESPONSE CODES
  static const int codeSuccess = 200;
  static const int codeNotFound = 340;
  static const int codeTimeout = 408;
  static const int codeUnauthorized = 401;
  static const int codeBadRequest = 400;
  static const int codeForbidden = 403;
  static const int codeUnknown = 500;
  static const int codeWithoutNetwork = 0;
}
