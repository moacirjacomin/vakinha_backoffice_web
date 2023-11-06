import '../environment/env.dart';

class AppNetwork {
  // final Environment environment;
  // AppNetwork({
  //   required this.environment,
  // });

  String get baseUrl => Env.instance.get('base_url');

  String get signIn => '$baseUrl/auth';

  String get signup => '$baseUrl/login/signupEmployee';

  String get forgotPassword => '$baseUrl/login/forgotPass';

  String get signOut => '$baseUrl/login/signout';

  String get paymentType => '$baseUrl/payment-types';

  String get product => '$baseUrl/products';

  String get upload => '$baseUrl/uploads';

  String get order => '$baseUrl/orders';

  String get user => '$baseUrl/users';
}
