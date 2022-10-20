import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:orange_power_task/util/helper.dart';

import '../model/tariff_model.dart';
import '../service/services_manager.dart';

class TariffBloc {
  final Connectivity _connectivity = Connectivity();
  List<Results> tariffList = [];
  bool isToday = false;
  final tariffStreamController = StreamController<List<Results>>.broadcast();
  StreamSink<List<Results>> get tariffSink => tariffStreamController.sink;
  Stream<List<Results>> get tariffStream => tariffStreamController.stream;
  final tariffEventStreamController = StreamController.broadcast();
  StreamSink get tariffEventSink => tariffEventStreamController.sink;
  Stream get eventMatchStream => tariffEventStreamController.stream;

  TariffBloc() {
    _connectivity.onConnectivityChanged.listen((status) {
      if (status == ConnectivityResult.none) {
        tariffSink.addError("No Network Connection");
      } else {
        tariffEventSink.add(todayTime);
      }
    });
    eventMatchStream.listen((event) async {
      List<Results> tempResultList = [...tariffList];
      if (event.runtimeType != DateTime && event['key'] == 'filter') {
        if (event['index'] == 1) {
          tempResultList = tariffList.where((e) {
            DateTime valEnd = parseTime(e.validFrom!);
            var now = todayTime;
            DateTime dateFormatted = parseTime(formatTimeWithZ(now));
            return valEnd.isAfter(dateFormatted);
          }).toList();
          tempResultList.sort((p1, p2) {
            return Comparable.compare(
                p1.valueIncVat ?? 0.0, p2.valueIncVat ?? 0.0);
          });
        } else if (event['index'] == 2) {
          tempResultList.sort((p1, p2) {
            return Comparable.compare(
                p1.valueIncVat ?? 0.0, p2.valueIncVat ?? 0.0);
          });
          int index = 0;
          bool isLoop = true;
          while (isLoop) {
            tempResultList = tariffList.skip(index).take(4).toList();
            if (tempResultList.length == 4) {
              isLoop = false;
            }
            index += 1;
          }
        }
        tariffSink.add(tempResultList);
      } else {
        var responseTariffList = await getTariffList(
            periodFrom: formatYYYYMMDD(event),
            periodTo: formatYYYYMMDD(event.add(const Duration(days: 1))));
        if (responseTariffList != null) {
          tariffList = responseTariffList;
          isToday = tariffList.any(
              (element) => parseTime(element.validFrom!).isAfter(todayTime));
          tariffSink.add(responseTariffList);
        } else {
          tariffSink.addError("Something went wrong");
        }
      }
    });
  }
  void dispose() {
    tariffStreamController.close();
    tariffEventStreamController.close();
  }
}
