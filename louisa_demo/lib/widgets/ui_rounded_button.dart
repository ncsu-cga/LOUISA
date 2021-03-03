import 'package:flutter/material.dart';
import 'package:louisa_demo/utils/style.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.title, this.color, @required this.onPressed});
  final Color color;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 40.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
            ),
            onPressed: onPressed,
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
