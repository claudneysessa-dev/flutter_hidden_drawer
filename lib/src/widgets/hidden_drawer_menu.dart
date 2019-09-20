import 'package:flutter/material.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';
import 'package:flutter_hidden_drawer/src/providers/drawer_menu_state.dart';
import 'package:provider/provider.dart';

class HiddenDrawerMenu extends StatelessWidget {
  HiddenDrawerMenu({this.header, this.footer, @required this.menu})
      : assert(menu != null);

  final Widget header;
  final Widget footer;
  final List<DrawerMenu> menu;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final DrawerMenuState state = Provider.of(context);

    return Material(
      child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: size.height * .2,
              width: 250,
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: header != null ? header : Container()),
            ),
            SizedBox(
              height: size.height * .7,
              width: 250,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: menu.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      state.changeIndexState(index);
                      HiddenDrawer.of(context).handleDrawer();
                      menu[index].onPressed();
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      color: state.currentMenuIndex == index
                          ? Colors.blue
                          : Colors.white,
                      child: menu[index].child,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * .1,
              width: 250,
              child: footer != null ? footer : Container(),
            ),
          ],
        ),
      ),
    );
  }
}