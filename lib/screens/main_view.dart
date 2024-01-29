import 'package:flutter/material.dart';
import 'package:thsyd/screens/home_view.dart';
import 'package:thsyd/screens/account_view.dart';
import 'package:thsyd/screens/housemate.dart';
import 'package:thsyd/screens/jobhub.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  static const routeName = "/mainview";

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    JobHub(),
    HouseMate(),
    AccountView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.newspaper,
              ),
              label: "Today",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.work,
              ),
              label: "JobHub",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.other_houses_outlined,
              ),
              label: "HouseMate",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Account",
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black26,
        ),
      ),
    );
  }
}
