import 'package:flutter/material.dart';

import 'package:covid_19/pages/country_stat.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);
  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(suggestionList[index]['countryInfo']['flag']),
              ),
              title: Text(
                suggestionList[index]['country'],
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "Total Cases : " + suggestionList[index]['cases'].toString(),
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Coronad(suggestionList[index])));
              },
            ),
          );
        });
  }
}
