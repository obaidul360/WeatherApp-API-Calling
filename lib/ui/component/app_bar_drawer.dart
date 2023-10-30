import 'package:flutter/material.dart';

class AppBarDrawer extends StatelessWidget {
  const AppBarDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        ListTile(
          leading: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Home",
              style: TextStyle(
                  fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          trailing: Icon(Icons.home),),
        Divider(),
        ListTile(
          leading: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Profile",
              style: TextStyle(
                  fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          trailing: Icon(Icons.person),),

        Divider(),
        ListTile(
            leading: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "About",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        trailing: Icon(Icons.info),),
        Divider(),
        ListTile(
            leading: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            },
          child: Text(
            "Setting",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        trailing: Icon(Icons.settings),),
        Divider(),
      ],
    );
  }
}
