import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../_shared/presentation/extensions/size_extension.dart';
import '../../_shared/utils/web_util.dart';
import 'menu_button.dart';
import 'menu_enum.dart';

class SideMenuBar extends StatefulWidget {
  const SideMenuBar({super.key});

  @override
  State<SideMenuBar> createState() => _SideMenuBarState();
}

class _SideMenuBarState extends State<SideMenuBar> with HistoryBackListener {
  Menu? selectedMenu;
  var colapsed = false;

  @override
  void onHistoryBack(Event event) {
    // to force screen re-build to update selectedMenu from navigation history
    setState(() {
      selectedMenu = Menu.findByPath(Modular.to.path);
    });
  }

  @override
  void initState() {
    super.initState();

    var history = Modular.to.navigateHistory;

    print('.... SIDE MENU: ${history.last.name}');
    print('.... selectedMenu=$selectedMenu');

    // check current navigation history and select automatilly
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Menu.values.forEach((menuItem){ 
    //     if(history.last.name.contains(menuItem.route)){
    //       setState(() {
    //         selectedMenu = menuItem;
    //       });
    //     }
    //   } );
    // });

    selectedMenu = Menu.findByPath(Modular.to.path);
  }

  @override
  Widget build(BuildContext context) {
     

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: colapsed ? 90 : context.percentWidth(.18),
      height: double.infinity,
      // color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: colapsed ? Alignment.center : Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                setState(() {
                  colapsed = !colapsed;
                });
              },
              icon: Icon(colapsed ? Icons.keyboard_double_arrow_right : Icons.keyboard_double_arrow_left),
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
              shrinkWrap: true,
              itemCount: Menu.values.length,
              itemBuilder: (context, index) {
                final menu = Menu.values[index];
                return MenuButton(
                  menu: menu,
                  menuSelected: selectedMenu,
                  onPressed: (menu) {
                    setState(() {
                      selectedMenu = menu;
                      Modular.to.navigate(menu.route);
                    });
                  },
                );
              })
        ],
      ),
    );
  }
}
