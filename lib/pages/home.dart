import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:covid_19/pages/country_stat.dart';
import 'package:covid_19/pages/welcome_unboarding.dart';
import 'package:covid_19/pages/dashboard_main.dart';
import 'package:line_icons/line_icons.dart';
import 'package:connectivity/connectivity.dart';


void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: StartScreen()));
}

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  StreamSubscription connectivitySubscription;

  ConnectivityResult _previousResult;

  bool dialogshown = false;

  Future<bool> checkinternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Future.value(true);
      }
    } on SocketException catch (_) {
      return Future.value(false);
    }
  }

  @override
  void initState() {
    super.initState();

    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connresult) {
      if (connresult == ConnectivityResult.none) {
        dialogshown = true;
        showDialog(
          context: context,
          barrierDismissible: false,
          child: AlertDialog(
            title: Text("ERROR",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                )),
            content: Text("No Internet Connection Available.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                )),
            actions: <Widget>[
              FlatButton(
                onPressed: () => {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                },
                child: Text("EXIT"),
              ),
            ],
          ),
        );
      } else if (_previousResult == ConnectivityResult.none) {
        checkinternet().then((result) {
          if (result == true) {
            if (dialogshown == true) {
              dialogshown = false;
              Navigator.pop(context);
            }
          }
        });
      }

      _previousResult = connresult;
    });
  }

  @override
  void dispose() {
    super.dispose();

    connectivitySubscription.cancel();
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Welcome(),
    DashBoard(),
    ThuloCovid(),
    //menubar
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.black, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.white.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: GNav(
                gap: 3,
                activeColor: Colors.white,
                color: Colors.white,
                iconSize: 23,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.grey[800],
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.bar_chart,
                    text: 'Stats',
                  ),
                  GButton(
                    icon: LineIcons.globe,
                    text: 'Global',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
