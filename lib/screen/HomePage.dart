import 'package:flutter/material.dart';
import 'package:torrefacteurk/screen/FarmPage.dart';
import 'package:torrefacteurk/screen/RankPage.dart';
import 'package:torrefacteurk/utils/materialColorFromHex.dart';
import 'package:torrefacteurk/screen/DryingPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String idUser = "0";

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      FarmPage(idUser: idUser),
      DryingPage(idUser: idUser),
      FarmPage(idUser: idUser),
      FarmPage(idUser: idUser),
      RankPage(idUser: idUser,),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
        backgroundColor: MaterialColor(0xff766c42, color),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: ClipOval(
            child: Material(
              color: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () => {},
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.yard),
            label: "Farm",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass),
            label: "Dry",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handyman),
            label: "Craft",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_play),
            label: "CMTCM",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium),
            label: "Rank",
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: MaterialColor(0xff766C42, color),
        selectedItemColor: MaterialColor(0xff96520F, color),
        onTap: _onItemTapped,
      ),
    );
  }
}
