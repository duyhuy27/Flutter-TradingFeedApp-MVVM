import 'dart:convert';

class GoldModel {
  final String status;
  final String currency;
  final String unit;
  final DateTime startDate;
  final DateTime endDate;
  final Map<String, Rate> rates;

  GoldModel({
    required this.status,
    required this.currency,
    required this.unit,
    required this.startDate,
    required this.endDate,
    required this.rates,
  });

  factory GoldModel.fromJson(Map<String, dynamic> json) {
    return GoldModel(
      status: json["status"] ?? '',
      currency: json["currency"] ?? '',
      unit: json["unit"] ?? '',
      startDate: DateTime.parse(json["start_date"] ?? ''),
      endDate: DateTime.parse(json["end_date"] ?? ''),
      rates: (json["rates"] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, Rate.fromJson(value))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "currency": currency,
      "unit": unit,
      "start_date":
          "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
      "end_date":
          "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      "rates": rates.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class Rate {
  final Map<String, double> currencies;
  final DateTime date;
  final Metals metals;

  Rate({
    required this.currencies,
    required this.date,
    required this.metals,
  });

  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      currencies: (json["currencies"] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value.toDouble())),
      date: DateTime.parse(json["date"] ?? ''),
      metals: Metals.fromJson(json["metals"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "currencies": currencies,
      "date":
          "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      "metals": metals.toJson(),
    };
  }
}

class Metals {
  final double gold;
  final double palladium;
  final double platinum;
  final double silver;

  Metals({
    required this.gold,
    required this.palladium,
    required this.platinum,
    required this.silver,
  });

  factory Metals.fromJson(Map<String, dynamic> json) {
    return Metals(
      gold: json["gold"] ?? 0.0,
      palladium: json["palladium"] ?? 0.0,
      platinum: json["platinum"] ?? 0.0,
      silver: json["silver"] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "gold": gold,
      "palladium": palladium,
      "platinum": platinum,
      "silver": silver,
    };
  }
}

GoldModel goldModelFromJson(String str) => GoldModel.fromJson(json.decode(str));

String goldModelToJson(GoldModel data) => json.encode(data.toJson());
