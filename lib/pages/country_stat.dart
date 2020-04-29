import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covid_19/components/Search.dart';
import 'package:covid_19/components/style.dart';



void main() => runApp(MaterialApp(
      title: "Corona App",
      debugShowCheckedModeBanner: false,
      home: ThuloCovid(),
    ));

class ThuloCovid extends StatefulWidget {
  @override
  _ThuloCovidState createState() => _ThuloCovidState();
}

class _ThuloCovidState extends State<ThuloCovid> {
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
    fetchCountryData();
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

  // Taking Data From
  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Search(countryData));
            },
          ),
        ],
        title: Text('COUNTRY'),
        backgroundColor: Color(0xff38358f),
      ),
      backgroundColor: Color(0xff38358f),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: countryData == null ? 0 : countryData.length,
        itemBuilder: (context, index) {
          return Card(
            color: Color.fromRGBO(76, 77, 185, 0),
            margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(countryData[index]['countryInfo']['flag']),
              ),
              title: Text(
                countryData[index]['country'],
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "Total Cases : " + countryData[index]['cases'].toString(),
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Coronad(countryData[index])));
              },
            ),
          );
        },
      ),
    );
  }
}

class Coronad extends StatelessWidget {
  final countryData;
  Coronad(this.countryData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COUNTRY STATS", textAlign: TextAlign.center),
        backgroundColor: Color(0xff38358f),
      ),
      body: ListView(shrinkWrap: true, children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(40),
              constraints: BoxConstraints.expand(height: 150),
              decoration: BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [lightpurple, purple],
                      begin: const FractionalOffset(1.0, 1.0),
                      end: const FractionalOffset(0.2, 0.2),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Text(
                'STAY AT HOME',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20.0,
                    color: Colors.white),
              ),
            ),
            Container(
              height: 100.0,
              width: 360.0,
              margin: EdgeInsets.fromLTRB(25.0, 90.0, 25.0, 0.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.grey)]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          height: 50.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  countryData['countryInfo']['flag']),
                              fit: BoxFit.fill,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(width: 45.0),
                  Container(
                    height: 60.0,
                    width: 155.0,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent[100].withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Center(
                      child: Text(countryData['country'],
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              color: Colors.green)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(blurRadius: 2.0, color: Colors.grey)
                    ]),
                height: 120,
                width: 160,
                child: Center(
                  child: Text(
                    'TOTAL CASES:' + countryData['cases'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(blurRadius: 2.0, color: Colors.grey)
                    ]),
                height: 120,
                width: 160,
                child: Center(
                  child: Text(
                    'TODAY CASES:' + countryData['todayCases'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(blurRadius: 2.0, color: Colors.grey)
                    ]),
                height: 120,
                width: 160,
                child: Center(
                  child: Text(
                    'DEATHS:' + countryData['deaths'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(blurRadius: 2.0, color: Colors.grey)
                    ]),
                height: 120,
                width: 160,
                child: Center(
                  child: Text(
                    'TODAY DEATH:' + countryData['todayDeaths'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(blurRadius: 2.0, color: Colors.grey)
                    ]),
                height: 120,
                width: 160,
                child: Center(
                  child: Text(
                    'RECOVERED:' + countryData['recovered'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(blurRadius: 2.0, color: Colors.grey)
                    ]),
                height: 120,
                width: 160,
                child: Center(
                  child: Text(
                    'SERIOUS CASES:' + countryData['critical'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
