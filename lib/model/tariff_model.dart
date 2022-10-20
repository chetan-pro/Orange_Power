class TariffData {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  TariffData({this.count, this.next, this.previous, this.results});

  TariffData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  double? valueExcVat;
  double? valueIncVat;
  String? validFrom;
  String? validTo;

  Results({this.valueExcVat, this.valueIncVat, this.validFrom, this.validTo});

  Results.fromJson(Map<String, dynamic> json) {
    valueExcVat = json['value_exc_vat'];
    valueIncVat = json['value_inc_vat'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value_exc_vat'] = valueExcVat;
    data['value_inc_vat'] = valueIncVat;
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    return data;
  }
}
