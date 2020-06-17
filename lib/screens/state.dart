import 'package:flutter/material.dart';

class MyState extends StatelessWidget {
  var state;
  MyState({var state}) {
    this.state = state;
  }
  @override
  Widget build(BuildContext context) {
    String name = state['state'];
    List district = state['districtData'];
    return Scaffold(
      appBar: AppBar(
        title: Text('$name'),
      ),
      body: ListView(
        children: <Widget>[
          for (int i = 0; i < district.length; i++) DistrictCard(district[i])
        ],
      ),
    );
  }

  Widget DistrictCard(district) {
    int confirmed = district['confirmed'];
    String name = district['name'];
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 4.0,
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
              'Confirmed : $confirmed',
              style: TextStyle(fontSize: 17.0),
            ),
          ],
        ),
      ),
    );
  }
}

// {
// "id": "Mumbai",
// "state": null,
// "name": "Mumbai",
// "confirmed": 60228,
// "recovered": null,
// "deaths": null,
// "oldConfirmed": 0,
// "oldRecovered": null,
// "oldDeaths": null,
// "zone": "NONE"
// }
