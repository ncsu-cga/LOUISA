import 'package:flutter/material.dart';

import 'package:louisa_demo/models/utils.dart';
import 'package:louisa_demo/screens/help_screen.dart';
import 'package:louisa_demo/widgets/ui_home_card_button.dart';
// Screen
import 'package:louisa_demo/screens/home/paticipant_home_screen.dart';
import 'package:louisa_demo/screens/auth/login_screen.dart';
import 'package:louisa_demo/screens/about.dart';
import 'package:louisa_demo/demo.dart';

class PaticipantNavScreen extends StatefulWidget {
  static const id = 'paticipant_nav_screen';

  @override
  _PaticipantNavScreenState createState() => _PaticipantNavScreenState();
}

class _PaticipantNavScreenState extends State<PaticipantNavScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = [
    // PaticipantHomeScreen(),
    PaticipantHomeScreen(),
    AboutScreen(),
    AboutScreen(),
    AboutScreen(),
  ];

  // return Center(
  //   child: Text("There is no page builder for this index."),
  // );

  // Create UI - card list buttons
  List<Widget> createCardListButtons(List<CardButton> items) {
    List<Widget> cardButtonItems = [];
    for (CardButton item in items) {
      var newItem = CardButton(title: item.title, onTap: item.onTap);
      cardButtonItems.add(newItem);
      cardButtonItems.add(Divider());
    }
    return cardButtonItems;
  }

  Widget _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOUISA'),
        centerTitle: true,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
