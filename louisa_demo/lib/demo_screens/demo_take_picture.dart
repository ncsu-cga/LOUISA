import 'package:flutter/material.dart';
import 'package:louisa_demo/demo_screens/demo_send_picture.dart';
import 'package:louisa_demo/widgets/ui_appbar_widget.dart';

class DemoTakePictureScreen extends StatelessWidget {
  static const id = 'demo_take_picture_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithCloseDefault(context, 'Daily Environment Survey'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'If you would like to include a picture, it cannot be transmitted to LDEQ but can provide evidence for citizen records.',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(1.0),
              child: Center(
                child: Icon(Icons.camera, size: 80.0),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                // border: Border.all(
                //   color: controller != null ? Colors.redAccent : Colors.grey,
                //   width: 3.0,
                // ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                icon: const Icon(Icons.camera_alt, size: 46.0),
                color: Colors.blue,
                onPressed: () {
                  Navigator.popAndPushNamed(context, DemoSendPictureScreen.id);
                  //onTakePictureButtonPressed(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
