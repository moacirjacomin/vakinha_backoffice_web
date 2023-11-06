import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/_shared/constants/app_styles.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/login');

    return MaterialApp.router(
      title: 'DW23-10',
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
      theme: ThemeConfig.theme,
    );
  }
}
