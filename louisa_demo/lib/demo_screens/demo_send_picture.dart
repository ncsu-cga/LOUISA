import 'package:flutter/material.dart';
import 'package:louisa_demo/widgets/ui_appbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:louisa_demo/screens/home/paticipant_nav_bottom.dart';
import 'package:louisa_demo/utils/constant.dart';

class DemoSendPictureScreen extends StatelessWidget {
  static const id = 'demo_send_picture_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithCloseDefault(context, 'Daily Environment Survey'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Container(
          //   padding: EdgeInsets.all(8.0),
          //   child: Text(
          //     'If you would like to include a picture, it cannot be transmitted to LDEQ but can provide evidence for citizen records.',
          //     style: TextStyle(
          //       fontSize: 20.0,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(1.0),
              child: Center(
                child: Icon(Icons.image, size: 80.0),
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
                icon: const Icon(Icons.send_rounded, size: 46.0),
                color: Colors.blue,
                onPressed: () {
                  imageSentDialog(context);
                  //Navigator.popAndPushNamed(context, );
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
              Navigator.popAndPushNamed(context, PaticipantNavScreen.id);
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
