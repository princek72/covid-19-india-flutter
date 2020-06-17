import 'dart:convert';

import 'package:covid_india/screens/state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String covidServerURL = 'https://api.covidindiatracker.com/state_data.json';
  List covidData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: covidData.length == 0
            ? LinearProgressIndicator()
            : ListView(
                children: <Widget>[
                  for (int i = 0; i < covidData.length; i++)
                    CoranavirusCard(covidData[i])
                ],
              ),
      ),
    );
  }

  Widget CoranavirusCard(stateData) {
    String name = stateData['state'];
    int active = stateData['active'];
    int recovery = stateData['recovered'];
    int deaths = stateData['deaths'];
    int confirm = stateData['confirmed'];
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          PageRoute route = MaterialPageRoute(
            builder: (context) => MyState(state: stateData),
          );
          Navigator.push(context, route);
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$name',
                style: TextStyle(fontSize: 25.0),
              ),
              Text(
                'Confirm : $confirm',
                style: TextStyle(fontSize: 17.0),
              ),
              Text(
                'Active : $active',
                style: TextStyle(fontSize: 17.0),
              ),
              Text(
                'Recovered : $recovery',
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.green,
                ),
              ),
              Text(
                'Death : $deaths',
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    covidData = [];
    setState(() {});
    http.Response response = await http.get(covidServerURL);
    var body = response.body;
    covidData = json.decode(body);
    setState(() {});
  }
}
