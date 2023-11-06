import 'package:flutter/material.dart';

import '../_shared/presentation/extensions/size_extension.dart';
import 'menu/menu_bar.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;

  const BaseLayout({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final shortestSide = context.screenShortestSide;
    return Scaffold(
      //  appBar: AppBar(title: const Text(''),),
      backgroundColor: Colors.black,
      body: SizedBox(
        height: context.screenHeight,
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              alignment: Alignment.centerLeft,
              constraints: BoxConstraints(
                minWidth: screenWidth,
                minHeight: shortestSide * .15,
                maxHeight: shortestSide * .15,
              ),
              child: Container(
                width: shortestSide * .14,
                margin: EdgeInsets.only(left: 20),
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            ),
            Positioned.fill(
              top: shortestSide * .12,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    SideMenuBar(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 35),
                        // padding: EdgeInsets.only(left: 15),
                        color: Colors.grey[50],
                        child: body,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
