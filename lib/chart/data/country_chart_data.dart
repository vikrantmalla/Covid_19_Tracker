import 'package:flutter/material.dart';
import 'package:covid_19/chart/extra/pie_chart.dart';
import 'package:line_icons/line_icons.dart';

class Coronad extends StatelessWidget {
  final countryData;
  Coronad(this.countryData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
                Container(
                            margin:
                                const EdgeInsets.only(right: 10.0),
                            height: 35.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    countryData['countryInfo']['flag']),
                                fit: BoxFit.fill,
                              ),
                            )),
              Text((countryData['country']),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xff38358f),

      ),
      backgroundColor: Color(0xff38358f),
       body: Container(
        child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 24),
          ),
          PieChart(
            dataMap: {
              'Cases': countryData['cases'].toDouble(),
              'Active': countryData['active'].toDouble(),
              'Recovered': countryData['recovered'].toDouble(),
              'Deaths': countryData['deaths'].toDouble(),
            },
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32.0,
            chartRadius: MediaQuery.of(context).size.width / 1.5,
            showChartValuesInPercentage: true,
            showChartValues: false,
            showChartValuesOutside: true,
            showLegends: false,
            decimalPlaces: 1,
            showChartValueLabel: true,
            initialAngle: 1.1,
            chartType: ChartType.ring,
            chartValueStyle: TextStyle(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon( LineIcons.circle,
                          color: Color(0xFFEEDA28), size: 15),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Cases',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    ],
                  ),
                  Text(
                    countryData['cases'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon( LineIcons.circle,
                          color: Color(0xFFE99600), size: 15),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Active Cases',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    ],
                  ),
                  Text(
                    countryData['active'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon( LineIcons.circle,
                          color: Color(0xFF70A901), size: 15),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Recovered',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    ],
                  ),
                  Text(
                    countryData['recovered'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon( LineIcons.circle,
                          color: Color(0xFFE40000), size: 15),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Deaths',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    ],
                  ),
                  Text(
                    countryData['deaths'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.white.withOpacity(0.4),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Critical',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8)),
                  ),
                  Text(
                    countryData['critical'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Today Cases',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8)),
                  ),
                  Text(
                    countryData['todayCases'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Today Deaths',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8)),
                  ),
                  Text(
                    countryData['todayDeaths'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Tests',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8)),
                  ),
                  Text(
                    countryData['tests'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
             Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Continent',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8)),
                  ),
                  Text(
                    countryData['continent'].toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          
        ]),
      ),
  );
  }
}