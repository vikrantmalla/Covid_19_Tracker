import 'package:flutter/material.dart';
import 'package:covid_19/chart/extra/pie_chart.dart';
import 'package:line_icons/line_icons.dart';


class Chart extends StatelessWidget {
  final worldData;
  Chart(this.worldData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SUMMARY"),
        centerTitle: true,
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
              'Cases': worldData['cases'].toDouble(),
              'Active': worldData['active'].toDouble(),
              'Recovered': worldData['recovered'].toDouble(),
              'Deaths': worldData['deaths'].toDouble(),
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
                    worldData['cases'].toString(),
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
                    worldData['active'].toString(),
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
                    worldData['recovered'].toString(),
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
                    worldData['deaths'].toString(),
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
                    worldData['critical'].toString(),
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
                    worldData['todayCases'].toString(),
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
                    worldData['todayDeaths'].toString(),
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
                    worldData['tests'].toString(),
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
                    'Affected Countries',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8)),
                  ),
                  Text(
                    worldData['affectedCountries'].toString(),
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
