import 'package:flutter/material.dart';
import 'package:louisa_demo/services/notifications.dart';

import 'package:louisa_demo/widgets/ui_appbar_widget.dart';
//import 'package:louisa_app/services/notifications.dart';

class LocalNotificationScreen extends StatefulWidget {
  static const id = 'local_notification_screen';
  @override
  _LocalNotificationScreenState createState() =>
      _LocalNotificationScreenState();
}

class _LocalNotificationScreenState extends State<LocalNotificationScreen> {
  @override
  void initState() {
    super.initState();

    notificationPlugin
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithCloseDefault(context, 'Local Notifications Text'),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            //await notificationPlugin.showNotification();
            await notificationPlugin.scheduleDailyNotification();
            
          },
          child: Text('Send Notification'),
        ),
      ),
    );
    
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    //
  }

  onNotificationClick(String payload) {
    print(payload);
  }
}
