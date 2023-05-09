// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/countries_list.dart';
import 'package:covid_tracker/world_states_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    StatesServices stateServices = StatesServices();
    return MaterialApp(
        home: Scaffold(
            body: Column(
      children: [
        SizedBox(height: 10),
        FutureBuilder(
            future: stateServices.fetchWorldStatesRecords(),
            builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Container(
                      height: 400,
                      child: Center(child: CircularProgressIndicator())),
                );
              } else {
                return Column(
                  children: [
                    PieChart(
                      dataMap: {
                        "total": double.parse(snapshot.data!.cases!.toString()),
                        "recovered":
                            double.parse(snapshot.data!.recovered!.toString()),
                        "death":
                            double.parse(snapshot.data!.deaths!.toString()),
                      },
                      chartValuesOptions:
                          ChartValuesOptions(showChartValuesInPercentage: true),
                      chartRadius: 140,
                      legendOptions:
                          LegendOptions(legendPosition: LegendPosition.left),
                      animationDuration: Duration(milliseconds: 1200),
                      chartType: ChartType.ring,
                      colorList: [Colors.red, Colors.blue, Colors.yellow],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      height: 440,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black38,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total"),
                              Text(snapshot.data!.cases.toString()),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Deaths"),
                              Text(snapshot.data!.deaths.toString()),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Recovered"),
                              Text(snapshot.data!.recovered.toString()),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Active"),
                              Text(snapshot.data!.active.toString()),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Critical"),
                              Text(snapshot.data!.critical.toString()),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Todays death"),
                              Text(snapshot.data!.todayDeaths.toString()),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Todays recovered"),
                              Text(snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CountriesListScreen()));
                        },
                        child: Text("Track Countries"))
                  ],
                );
              }
            }),
      ],
    )));
  }
}
