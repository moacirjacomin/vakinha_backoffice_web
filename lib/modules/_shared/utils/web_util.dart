import 'dart:html';
import 'dart:ui_web';

import 'package:flutter/cupertino.dart';

mixin HistoryBackListener<T extends StatefulWidget> on State<T> {
  final _location = const BrowserPlatformLocation();

  void onHistoryBack(Event event) {}

  @override
  void initState() {
    super.initState();
    _location.addPopStateListener((event) async {
      await Future.delayed(Duration(milliseconds: 200));
      if (mounted) {
        onHistoryBack(event as Event);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _location.removePopStateListener((event) => null);
  }
}
