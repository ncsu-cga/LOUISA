import 'package:flutter/material.dart';

import 'package:louisa_demo/models/utils.dart';
import 'package:louisa_demo/widgets/ui_home_card_button.dart';

class DemoHome extends StatefulWidget {
  static const id = 'demo_home_screen';
  @override
  _DemoHomeState createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  List<CardButtonItems> cardButtonItems = [
    CardButtonItems(
        title: 'Onetime Survey',
        onTap: () {
          //Navigator.pushNamed(context, MyHealthScreen.id);
        }),
    CardButtonItems(
      title: 'Daily Health Survey',
      onTap: null,
    ),
    CardButtonItems(
      title: 'Daily Environment Survey',
      onTap: () {},
    ),
  ];

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: createCardListButtons(cardButtonItems),
          ),
        ),
      ),
    );
  }
}
