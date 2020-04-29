import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covid_19/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // No need of streamsubscription
  ConnectivityResult previous;

  @override
  void initState() {
    super.initState();
    try {
      InternetAddress.lookup('google.com').then((result) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          // internet conn available
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => StartScreen(),
          ));
        } else {
          // no conn
          _showdialog();
        }
      }).catchError((error) {
        // no conn
        _showdialog();
      });
    } on SocketException catch (_) {
      // no internet
      _showdialog();
    }

    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connresult) {
      if (connresult == ConnectivityResult.none) {
      } else if (previous == ConnectivityResult.none) {
        // internet conn
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => StartScreen(),
        ));
      }

      previous = connresult;
    });
  }

  void _showdialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ERROR',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 15,
            )),
        content: Text("No Internet Detected.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            )),
        actions: <Widget>[
          FlatButton(
            // method to exit application programitacally
            onPressed: () =>
                SystemChannels.platform.invokeMethod('Systemnavigator.pop'),
            child: Text("EXIT"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff38358f),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("Checking Your Internet Connection.",  style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.white,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
