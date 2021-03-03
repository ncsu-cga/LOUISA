import 'package:flutter/material.dart';
import 'package:louisa_demo/demo_screens/demo_send_picture.dart';
import 'package:louisa_demo/demo.dart';
import 'package:louisa_demo/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:louisa_demo/utils/style.dart';

class DemoTakePictureScreen extends StatelessWidget {
  static const id = 'demo_take_picture_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Daily Environment Survey'),
      ),
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
                //color: Colors.black,
                border: Border.all(
                  color: Colors.grey,
                  width: 3.0,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80.0,
        child: SafeArea(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextButton(
                    child: Text(
                      'Cancel',
                      style:
                          TextStyle(fontSize: 16.0, color: kPrimaryLightColor),
                    ),
                    onPressed: () {
                      completeDialog(context);
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: const Icon(
                      Icons.camera_alt_sharp,
                      size: 40.0,
                    ),
                    color: kPrimaryLightColor,
                    onPressed: () {
                      Navigator.pushNamed(context, DemoSendPictureScreen.id);
                      //onTakePictureButtonPressed(context);
                    },
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future completeDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Thank you!'),
        content: const Text(
          'Would you like to finish or file complaint with the State of Louisiana today?',
        ),
        actions: [
          TextButton(
            child: const Text('Finish'),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName(DemoHome.id));
              //Navigator.popAndPushNamed(context, DemoHome.id);
            },
          ),
          TextButton(
            child: const Text('File complaint'),
            onPressed: () {
              launch(Const.LDEQ_COMPLAINT_URL);
            },
          )
        ],
      );
    },
  );
}
