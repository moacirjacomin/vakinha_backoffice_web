import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_module.dart';
import 'app_widget.dart';
import 'modules/_shared/data/environment/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Env.instance.load();

  runApp(ModularApp(
    module: AppModule(),
    child: AppWidget(),
  ));
}
