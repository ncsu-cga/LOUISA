import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  CardButton({this.title, this.onTap});

  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: ListTile(
        leading: FlutterLogo(size: 56.0),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        dense: true,
        trailing: Icon(Icons.navigate_next),
        title: Text(
          title,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w100),
        ),
        // subtitle: Text('Here is a second line'),
        onTap: onTap,
      ),
    );
  }
}
