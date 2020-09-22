import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map sunSetSunRiseData;
  getAllData() async {
    var api =
        'https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400';
    http.Response data = await http.get(api);

    setState(() {
      sunSetSunRiseData = json.decode(data.body);
    });
  }

  Future fetchData() async {
    getAllData();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sunrise Sunset TimeFinder'),
        backgroundColor: Color(0xfffeb53b),
      ),
      drawer: Drawer(),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Image(
                  image: AssetImage("images/Sunrise.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              sunSetSunRiseData == null
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    )
                  : Positioned(
                      left: 50,
                      bottom: 10.0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xfffeb53b).withOpacity(0.4),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        margin: EdgeInsets.all(10.0),
                        height: 150.0,
                        width: 300.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sunrise Time is: ' +
                                  sunSetSunRiseData['results']['sunrise'],
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                                'Sunset Time is: ' +
                                    sunSetSunRiseData['results']['sunset'],
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white)),
                            SizedBox(height: 10.0),
                            Text(
                                'Solar Noon is: ' +
                                    sunSetSunRiseData['results']['solar_noon'],
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white)),
                            SizedBox(height: 10.0),
                            Text(
                                'Day Length is: ' +
                                    sunSetSunRiseData['results']['day_length'],
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white)),
                          ],
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
