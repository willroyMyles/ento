import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0, left: 10),
      padding: EdgeInsets.all(25),
      child: Column(
        children: [
          DrawerHeader(
            child: Text("ENTO"),
          ),
          Spacer(
            flex: 1,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.search),
            title: Text("search"),
            onTap: () {},
          ),
          Spacer(
            flex: 12,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.settings),
            title: Text("Log out"),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
