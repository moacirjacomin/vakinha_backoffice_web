import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';
import '../extensions/size_extension.dart';

class BaseHeaderWidget extends StatelessWidget {
  final String title;
  final ValueChanged<String>? searchChange;
  final String buttonLabel;
  final VoidCallback? buttonPressed;
  final bool addButton;
  final Widget? filterWidget;

  const BaseHeaderWidget({
    Key? key,
    required this.title,
    this.searchChange,
    required this.buttonLabel,
    this.buttonPressed,
    this.addButton = true,
    this.filterWidget,
  }) : super(key: key);

  Widget titleComponent(BoxConstraints constrains, BuildContext context, double maxPercentage, double? screenWidth) {
    return Container(
      width: constrains.maxWidth * maxPercentage,
      padding: EdgeInsets.all(8),
      child: Text(
        // screenWidth.toString() + title,
        title,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: context.textStyles.textTitle.copyWith(
          decorationThickness: 2,
          // decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.screenWidth;
    return LayoutBuilder(builder: (_, constrains) {
      double iconSize = screenWidth < 960 ? 20 : constrains.maxWidth * 0.02;
      double buttonSize = screenWidth < 960 ? 120 : constrains.maxWidth * .15;
      bool isSmall = screenWidth < 800;

      return Padding(
        padding: const EdgeInsets.only(top: 30.0, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isSmall) titleComponent(constrains, context, 1, screenWidth),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                //
                Visibility(
                  // visible: true,
                  visible: filterWidget == null,
                  replacement: filterWidget ?? SizedBox.shrink(),
                  child: SizedBox(
                    // width: constrains.maxWidth * .15,
                    width: constrains.maxWidth * (isSmall ? .40 : .20),
                    child: TextFormField(
                      onChanged: searchChange,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: Icon(
                            Icons.search,
                            size: iconSize,
                          ),
                          label: Text(
                            'Buscar',
                            style: context.textStyles.regular.copyWith(fontSize: 12, color: Colors.grey),
                          )),
                    ),
                  ),
                ),
                //
                //
                if (!isSmall) titleComponent(constrains, context, .55, screenWidth),
                //
                //
                Visibility(
                  visible: addButton == true,
                  child: SizedBox(
                    height: 40,
                    width: buttonSize,
                    child: OutlinedButton.icon(
                      onPressed: buttonPressed,
                      icon: Icon(Icons.add, size: iconSize),
                      label: Text(
                        buttonLabel,
                        style: context.textStyles.regular.copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
