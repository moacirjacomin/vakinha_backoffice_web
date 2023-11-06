

import 'dart:async';

import 'package:flutter/material.dart';
 
/*
  how to use: 
  var debounce = Debouncer(milliseconds:500);

  debounce.call(
    (){
      controller.doThis(value);
    }
  )
*/

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({
    required this.milliseconds,
  });

  void call(VoidCallback callback){
    _timer?.cancel();

    _timer = Timer(Duration(milliseconds: milliseconds), callback);
  }
}
