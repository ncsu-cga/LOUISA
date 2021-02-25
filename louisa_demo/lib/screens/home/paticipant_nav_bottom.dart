import 'package:flutter/material.dart';

import 'package:louisa_demo/models/utils.dart';
import 'package:louisa_demo/widgets/ui_home_card_button.dart';
// Screen
import 'package:louisa_demo/screens/home/paticipant_home_screen.dart';
import 'package:louisa_demo/screens/auth/login_screen.dart';

class PaticipantNavScreen extends StatefulWidget {
  static const id = 'paticipant_nav_screen';

  @override
  _PaticipantNavScreenState createState() => _PaticipantNavScreenState();
}

class _PaticipantNavScreenState extends State<PaticipantNavScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = [
    PaticipantHomeScreen(),
    // AboutScreen(),
  ];

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return PaticipantNavScreen(); // Create this function, it should return your first page as a widget
      case 1:
        return LoginScreen(); // Create this function, it should return your second page as a widget
      case 2:
        return LoginScreen(); // Create this function, it should return your third page as a widget
      case 3:
        return LoginScreen(); // Create this function, it should return your fourth page as a widget
    }

    // return Center(
    //   child: Text("There is no page builder for this index."),
    // );
  }

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // print(index.toString());
    // if (index != 0) {
    //   setState(() {
    //     _selectedIndex = index;
    //   });
    //   //Navigator.of(context).popAndPushNamed(_getBody(_selectedIndex));
    // }
    // else {
    //   print('Something wrong');
    //   // Navigator.of(context).push(
    //   //   MaterialPageRoute(builder: (context) => LoginScreen()),
    //   // );
    // }
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
