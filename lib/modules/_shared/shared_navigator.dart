import 'package:flutter_modular/flutter_modular.dart';

import '../auth/auth_module.dart';
import '../home/home_module.dart';

 

class SharedNavigator {
  SharedNavigator();
  //   SharedNavigator._();
  // static final SharedNavigator _instance = SharedNavigator._();

  // static SharedNavigator setup() {
  //   return _instance;
  // }

  void openLogin() {
    return Modular.to.navigate(AuthModule.moduleName);
  }

  void openHome() {
    Modular.to.navigate(HomeModule.moduleName);
  }

  void back() {
    Modular.to.pop();
  }

  // void openOrderRequestModal(OrderRequest order) {
  //   Modular.to.pushNamed(
  //     OrderRequestModule.moduleName,
  //     arguments: order,
  //   );
  // }
 
  
}
