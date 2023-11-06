import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// package: https://pub.dev/packages/loading_animation_widget
// use exmple: 
// in a statefull widget add 'with Loader' 
// class _HomePageState extends State<HomePage> with Loader{

mixin Loader<T extends StatefulWidget> on State<T> {
  var isOpen = false;

  void showLoader() {
    if (!isOpen) {
      isOpen = true;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) => LoadingAnimationWidget.threeArchedCircle(
              color: Colors.white,
              size: 60,
            )),
      );
    }
  }

  void hideLoader() {
    if(isOpen){
      isOpen = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  void dispose() {
    hideLoader();
    super.dispose();
  }
}
