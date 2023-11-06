import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends Module {
  static const moduleName = '/home';
//  @override
//   List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
 
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage());
    // r.module('/', module: SplashModule());
    // r.module('/home', module: HomeModule());
    // r.module('/auth', module: AuthModule());
  }
}