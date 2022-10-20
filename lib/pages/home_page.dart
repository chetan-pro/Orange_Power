import 'package:calender_picker/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:orange_power_task/util/constant.dart';
import '../model/tariff_model.dart';
import '../bloc/tariff_bloc.dart';
import '../util/helper.dart';
import 'line_chart.dart';
import 'data_table.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final tariffBloc = TariffBloc();
  int filterIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tariffBloc.dispose();
    super.dispose();
  }

  callStreamFilter(int index) {
    filterIndex = index;
    tariffBloc.tariffEventSink.add({'key': 'filter', 'index': index});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.purpleDark,
      appBar: AppBar(
          backgroundColor: Constants.purpleDark,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Standard Tariff",
            style: TextStyle(
              fontSize: 17,
              color: Constants.white,
            ),
          )),
      body: SingleChildScrollView(
          child: Center(
        child: StreamBuilder<List<Results>>(
          stream: tariffBloc.tariffStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/no_network.png',
                          color: Constants.white,
                          width: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          (snapshot.error ?? "No Data Found").toString(),
                          style: const TextStyle(
                              color: Constants.white, fontSize: 15),
                        ),
                      ],
                    ),
                  ));
            }
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CalenderPicker(
                        todayTime.subtract(const Duration(days: 5)),
                        daysCount: 6,
                        initialSelectedDate: todayTime,
                        enableMultiSelection: false,
                        selectionColor: Constants.purpleLight,
                        selectedTextColor: Constants.white,
                        onDateChange: (time) {
                      filterIndex = 0;

                      tariffBloc.tariffEventSink.add(time);
                    }),
                  ),
                  LineChartScreen(
                    results: snapshot.data ?? [],
                  ),
                  PanelCenterPage(
                    results: snapshot.data?.reversed.toList() ?? [],
                    func: callStreamFilter,
                    filterIndex: filterIndex,
                    tariffBlocInstance: tariffBloc,
                  )
                ],
              );
            } else {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: const Center(child: CircularProgressIndicator()));
            }
          },
        ),
      )),
    );
  }
}

class Tariff {
  final String time;
  final int includeVat;
  final charts.Color color;

  Tariff(this.time, this.includeVat, Color color)
      : color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
