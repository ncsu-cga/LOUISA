import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:louisa_demo/utils/constant.dart';
import 'package:louisa_demo/demo.dart';
import 'package:louisa_demo/utils/style.dart';

class DemoSendPictureScreen extends StatelessWidget {
  static const id = 'demo_send_picture_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daily Environment Survey')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(1.0),
              child: Center(
                child: Icon(Icons.image, size: 80.0),
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
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 80.0,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: const Icon(Icons.send_sharp, size: 40.0),
                  color: kPrimaryLightColor,
                  onPressed: () {
                    imageSentDialog(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future imageSentDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Thank you!'),
        content: const Text(
          'Image was sent to the server.  Would you like to finish or file complaint with the State of Louisiana today?',
        ),
        actions: [
          TextButton(
            child: const Text('Finish'),
            onPressed: () {
              //Navigator.pop(context);
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
