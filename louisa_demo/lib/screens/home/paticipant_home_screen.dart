import 'package:flutter/material.dart';

import 'package:louisa_demo/models/utils.dart';
import 'package:louisa_demo/widgets/ui_home_card_button.dart';

class PaticipantHomeScreen extends StatefulWidget {
  static const id = 'paticipant_home_screen';

  @override
  _PaticipantHomeScreenState createState() => _PaticipantHomeScreenState();
}

class _PaticipantHomeScreenState extends State<PaticipantHomeScreen> {
  String token = 'logged_in';
  bool consent = false;
  // Create UI - card list buttons
  List<Widget> createCardListButtons(List<CardButtonItems> items) {
    List<Widget> cardButtonItems = [];
    for (CardButtonItems item in items) {
      var newItem = CardButton(title: item.title, onTap: item.onTap);
      cardButtonItems.add(newItem);
      cardButtonItems.add(Divider());
    }
    return cardButtonItems;
  }

  @override
  Widget build(BuildContext context) {
    List<CardButtonItems> cardButtonItems = [
      CardButtonItems(
          title: 'My Health Symptom',
          onTap: () {
              //Navigator.pushNamed(context, MyHealthScreen.id);
          }),
      CardButtonItems(
        title: 'My Community Health',
        onTap: null,
      ),
      CardButtonItems(
        title: 'My Local Air Quality',
        onTap: () {},
      ),
      CardButtonItems(
        title: 'Report an Environmental Problem',
        onTap: () {},
      ),
      CardButtonItems(
        title: 'Read Other Air Pollution problem',
        onTap: () {},
      ),
    ];

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            children: [
              Text(
                "Thank you for visiting! Learn how air pollution affects your health.  Report an air quality problem. ",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: ListView(
                  children: createCardListButtons(cardButtonItems),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
