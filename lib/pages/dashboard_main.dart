import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covid_19/components/style.dart';

void main() => runApp(MaterialApp(
      title: "Corona App",
      debugShowCheckedModeBanner: false,
      home: DashBoard(),
    ));

class DashBoard extends StatefulWidget {
  @override
  _DashBoard createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
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
    fetchData();
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
            title: Text(
              "ERROR",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            content: Text(
              "No Internet Connection Available.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
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

  Map worldData;
  fetchWorldWideData() async {
    var response =
        await http.get('https://brp.com.np/covid/alldata.php');
    setState(() {
      worldData = json.decode(response.body);

    });
  }
  Future fetchData() async {
    fetchWorldWideData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'COVID-19 TRACKER',
          ),
          backgroundColor: Color(0xff38358f),
        ),
        backgroundColor: Color(0xff38358f),
        body: RefreshIndicator(
          onRefresh: fetchData,
                  child: Container(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text('Last Update:' + worldData['statistic_taken_at'].toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(color: AppStyle.txg),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    color: Color.fromRGBO(76, 77, 185, 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('CASES',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Color(0xFFFFF492))),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("assets/cases.png",
                                    color: Color(0xFFFFF492)),
                                Text(worldData['total_cases'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Color(0xFFFFF492))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    color: Color.fromRGBO(76, 77, 185, 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('ACTIVE CASES',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Color(0xFFEEDA28))),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("assets/active.png",
                                    color: Color(0xFFEEDA28)),
                                Text(worldData['active_cases'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Color(0xFFEEDA28))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    color: Color.fromRGBO(76, 77, 185, 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('CRITICAL CASES',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Color(0xFFE99600))),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("assets/critical.png",
                                    color: Color(0xFFE99600)),
                                Text(worldData['serious_critical'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Color(0xFFE99600))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    color: Color.fromRGBO(76, 77, 185, 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('RECOVERED',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Color(0xFF70A901))),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("assets/recovered.png",
                                    color: Color(0xFF70A901)),
                                Text(worldData['total_recovered'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Color(0xFF70A901))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    color: Color.fromRGBO(76, 77, 185, 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('DEATHS',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Color(0xFFE40000))),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 52,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("assets/death.png",
                                    color: Color(0xFFE40000)),
                                Text(worldData['total_deaths'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Color(0xFFE40000))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
