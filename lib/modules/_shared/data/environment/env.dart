// OPTIONAL
// The idea of this class is to work as utility to package flutter_dotenv
// if this environment variables approuch will be use, install the package
// https://pub.dev/packages/flutter_dotenv
// 
// require a .env file in the main folder
// and pubspec.yaml should be edit to hava aline .env in the assets session

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static Env? _instance;

  Env._();
  static Env get instance => _instance ??= Env._();

  Future<void> load() => dotenv.load();

  String? maybeGet(String key) => dotenv.maybeGet(key);

  String get(String key) => dotenv.get(key);
}



// a version using dotenv locally and firebase config:

// class Environments {
//   Environments._();

//   static String? param(String paramName) {
//     if (kReleaseMode) {
//       return FirebaseRemoteConfig.instance.getString(paramName);
//     } else {
//       return dotenv.env[paramName];
//     }
//   }

//   static Future<void> loadEnvs() async {
//     if (kReleaseMode) {
//       final remoteConfig = FirebaseRemoteConfig.instance;
//       await remoteConfig.setConfigSettings(
//         RemoteConfigSettings(
//           fetchTimeout: const Duration(minutes: 1),
//           minimumFetchInterval: const Duration(hours: 1),
//         ),
//       );
//       await remoteConfig.fetchAndActivate();
//     } else {
//       await dotenv.load(fileName: ".env");
//     }
//   }
// }