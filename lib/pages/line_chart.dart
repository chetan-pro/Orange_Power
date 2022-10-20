// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../model/tariff_model.dart';
import '../util/constant.dart';
import '../util/helper.dart';

class LineChartScreen extends StatefulWidget {
  List<Results> results;
  LineChartScreen({Key? key, required this.results}) : super(key: key);
  @override
  _LineChartScreenState createState() => _LineChartScreenState();
}

class _LineChartScreenState extends State<LineChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Constants.kPadding / 2,
          top: Constants.kPadding,
          bottom: Constants.kPadding,
          right: Constants.kPadding / 2),
      child: Card(
        color: Constants.purpleLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 3,
        child: Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 12.0, left: 6.0, top: 24, bottom: 6),
                  child: LineChart(
                    mainData(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData mainData() {
    List<Results> reveredResult = [...widget.results.reversed];
    reveredResult.sort((p1, p2) {
      return Comparable.compare(
          parseTime(p1.validFrom!), parseTime(p2.validFrom!));
    });
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return flLine;
        },
        getDrawingVerticalLine: (value) {
          return flLine;
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          rotateAngle: 90,
          getTextStyles: (value, i) => const TextStyle(
              color: Constants.chartTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 12),
          getTitles: (value) {
            String str = '';
            try {
              if (value.toInt() % 2 == 0) {
                str =
                    ("${parseTime(reveredResult[value.toInt()].validFrom!).hour}");
              }
            } catch (e) {
              str = '';
            }
            return str;
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value, i) => const TextStyle(
            color: Constants.chartTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            if (value.toInt() % 4 == 0) {
              return '${value.toInt()}';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      axisTitleData: FlAxisTitleData(
        leftTitle: axisTitle('Price in £'),
        bottomTitle: axisTitle('24 Hour Format'),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Constants.lineColor, width: 1)),
      lineBarsData: [
        LineChartBarData(
          spots: [
            ...List.generate(
                reveredResult.length,
                (index) => FlSpot(
                    index + 0.0, reveredResult[index].valueIncVat ?? 0.0))
          ],
          isCurved: true,
          colors: Constants.lightGradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: Constants.lightGradientColors
                .map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ],
    );
  }

  AxisTitle axisTitle(text) => AxisTitle(
      titleText: '$text',
      showTitle: true,
      textStyle: const TextStyle(
        color: Constants.chartTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ));

  FlLine flLine = FlLine(
    color: Constants.lineColor,
    strokeWidth: 1,
  );
}
