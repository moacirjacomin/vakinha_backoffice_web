import 'dart:io';

// import 'package:all_validations_br/all_validations_br.dart';
import 'package:intl/intl.dart';

class StringUtils {
  static String extractState(String text) {
    return text.split('-').last.trim();
  }

  static String extractNumer(String text) {
    RegExp regex = RegExp(r'\d+'); // Expressão regular para encontrar números inteiros
    Match? match = regex.firstMatch(text);

    if (match == null) return '';

    return match.group(0).toString();
  }

  static String unmask(String value) {
    return value.replaceAll(' ', '').replaceAll('-', '').replaceAll('.', '').replaceAll('/', '').replaceAll('(', '').replaceAll(')', '');
  }

  static String extractAreaCode(String phoneValune) {
    if (!phoneValune.contains(')')) return '';

    return phoneValune.replaceAll('(', '').split(')')[0];
  }

  static String extractPhoneNumber(String phoneValune) {
    if (!phoneValune.contains(')')) return '';

    return unmask(phoneValune.split(')')[1]);
  }

  static String formatCpf(String cpf) {
    cpf = unmask(cpf);
    print('$cpf cpf.length=' + cpf.length.toString());
    if (cpf.length < 11) return cpf;

    // to clean:
    // return cpf.replaceAll(RegExp(r'[.-]'), "");

    // var result = cpf.substring(0, 3)+'.'+cpf.substring(3, 6)+'.'+cpf.substring(6, 9)+'-'+cpf.substring(9, 11);
    return "${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}";
  }

  static String durationToHourMin(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes';
  }

  static String intToMinAndSec(int time) {
    final min = (time / 60).floor();
    final sec = (time % 60).floor();
    return '${min < 10 ? '0' : ''}$min:${sec < 10 ? '0' : ''}$sec';
  }

  static bool isNullOrBlank(String? string) {
    if (string == null) return true;

    final str = string.replaceAll(' ', '');
    return str.isEmpty;
  }

  static String platformName() {
    if (Platform.isAndroid) {
      return 'android';
    } else {
      return 'ios';
    }
  }

  static String maskCreditCard(String stringComplete) {
    return '**** **** **** ${stringComplete.split(' ').last}';
  }

  static String toCurrency(double value) => NumberFormat.simpleCurrency(locale: 'pt-BR').format(value);

  static String toCurrencyWithSimbol(double value) => NumberFormat.currency(locale: 'pt-BR', symbol: r'R$').format(value);

  static String capitalize(String str) => '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}';

  static double? toDouble(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is double) {
      return value;
    } else {
      final str = value.toString().replaceAll(',', '.');
      return double.tryParse(str);
    }
  }

  ///Remove decimal digits if the first digit is Zero (ex: 12.0 becomes '12', and 12.5 continues '12.5')
  static String toStringWithNoDecimalZeros(double value) {
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);
  }

  // static Map<String, dynamic> stringGooglePlacesToMap(String addressText) {
  //   if (!addressText.contains(',')) {
  //     return {'city': '', 'address': '', 'country': ''};
  //   }
  //   /*
  //     R. Culto A Ciência - Campinas, SP, Brasil
  //     Av. Paulista, São Paulo - SP, Brasil
  //     R. Catiguá, 464 - Vila Celso Mauad, Catanduva - SP, 15809-190, Brasil
  //   */
  //   // adjust BR states
  //   var states = [
  //     'MG',
  //     'AC',
  //     'AL',
  //     'AP',
  //     'AM',
  //     'BA',
  //     'CE',
  //     'DF',
  //     'ES',
  //     'GO',
  //     'MA',
  //     'MT',
  //     'MS',
  //     'PA',
  //     'PB',
  //     'PR',
  //     'PE',
  //     'PI',
  //     'RJ',
  //     'RN',
  //     'RS',
  //     'RO',
  //     'RR',
  //     'SC',
  //     'SP',
  //     'SE',
  //     'TO'
  //   ];

  //   states.forEach((state) {
  //     addressText = addressText.replaceAll(', ${state.toLowerCase()}', ' - ${state.toUpperCase()}');
  //   });
  //   states.forEach((state) {
  //     addressText = addressText.replaceAll(', ${state}', ' - ${state.toUpperCase()}');
  //   });

  //   var addressVet = addressText.split(',');
  //   var country = addressVet[addressVet.length - 1].trim();

  //   // remove contry position
  //   addressVet.removeAt(addressVet.length - 1);
  //   //addressVet = addressVet.where((element) => !element.trim().toLowerCase().contains('brasil')).toList();
  //   //addressVet = addressVet.where((element) => !element.trim().toLowerCase().contains('brazil')).toList();

  //   // remove zipcode
  //   addressVet = addressVet.where((element) => !AllValidations.isValidBRZip(element.trim())).toList();

  //   var city = addressVet.last.trim();

  //   if (addressVet.length > 1) {
  //     addressVet.removeAt(addressVet.length - 1);
  //   }
  //   var address = addressVet.join(', ');

  //   return {
  //     'city': city,
  //     'address': address,
  //     'country': country,
  //   };
  // }
}
