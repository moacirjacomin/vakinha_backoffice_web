import 'package:flutter_modular/flutter_modular.dart';

 

class AuthNavigator {
  void pop() {
    return Modular.to.pop();
  }

  void openLogin() {
    return Modular.to.popUntil((route) => route.isFirst);
  }

 
 

  void openSignInPage() {
      Modular.to.pop();
    // return Modular.to.pushNamed(
    //   LoginPage.routePath,
    // );
  }
}
