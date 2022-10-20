// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:orange_power_task/bloc/tariff_bloc.dart';

import '../model/tariff_model.dart';
import '../util/constant.dart';
import '../util/helper.dart';

class PanelCenterPage extends StatefulWidget {
  List<Results> results;
  int filterIndex;
  TariffBloc tariffBlocInstance;
  Function func;
  PanelCenterPage(
      {Key? key,
      required this.results,
      required this.func,
      required this.filterIndex,
      required this.tariffBlocInstance})
      : super(key: key);

  @override
  State<PanelCenterPage> createState() => _PanelCenterPageState();
}

class _PanelCenterPageState extends State<PanelCenterPage> {
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Constants.kPadding / 2,
          right: Constants.kPadding / 2,
          bottom: Constants.kPadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                filterTextBox(text: 'All', index: 0),
                if (widget.tariffBlocInstance.isToday)
                  filterTextBox(text: 'Best Future Tariff', index: 1),
                filterTextBox(text: 'Cheapest 4 Tariff', index: 2),
              ],
            ),
          ),
          Card(
            color: Constants.purpleLight,
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Table(
              border: TableBorder.all(color: Constants.white.withOpacity(0.3)),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: Constants.lightGradientColors,
                    )),
                    children: [
                      tableHeadTitle('S no.'),
                      tableHeadTitle('Period From'),
                      tableHeadTitle('Period To'),
                      tableHeadTitle('Value'),
                    ]),
                ...List.generate(
                    widget.results.length,
                    (index) => TableRow(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                              colors: Constants.darkGradientColors,
                            )),
                            children: [
                              tableChildRow('${index + 1}'),
                              tableChildRow(onlyTimeFormat(
                                  widget.results[index].validFrom ?? '')),
                              tableChildRow(onlyTimeFormat(
                                  widget.results[index].validTo ?? '')),
                              tableChildRow(
                                  '£${widget.results[index].valueIncVat}'),
                            ])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  filterTextBox({text, index}) {
    return InkWell(
      onTap: () {
        widget.func(index);
      },
      child: Container(
        margin: const EdgeInsets.only(right: Constants.kPadding - 5),
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.kPadding + 6,
            vertical: Constants.kPadding - 2),
        decoration: BoxDecoration(
            color: widget.filterIndex == index
                ? Constants.purpleLight
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          '$text',
          style: tableChildTextStyle(),
        ),
      ),
    );
  }

  tableHeadTitle(text) {
    return TableCell(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.kPadding - 2),
      child: Center(
        child: Text(
          '$text',
          style: textStyle(),
        ),
      ),
    ));
  }

  tableChildRow(text) {
    return TableCell(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.kPadding - 4),
      child: Center(
        child: Text(
          '$text',
          style: tableChildTextStyle(),
        ),
      ),
    ));
  }

  textStyle() {
    return const TextStyle(
      color: Constants.purpleDark,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
  }

  tableChildTextStyle() {
    return const TextStyle(
      color: Constants.chartTextLightColor,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
  }
}
