// To parse this JSON data, do
//
//     final marketCapModel = marketCapModelFromJson(jsonString);

import 'dart:convert';

// List<MarketCapModel> marketCapModelFromJson(String str) =>
//     List<MarketCapModel>.from(
//         json.decode(str).map((x) => MarketCapModel.fromJson(x)));
List<MarketCapModel> marketCapModelFromJson(String str) {
  final jsonData = json.decode(str);
  if (jsonData is List) {
    // If jsonData is a List, directly convert it to a List<MarketCapModel>
    return jsonData.map((json) => MarketCapModel.fromJson(json)).toList();
  } else if (jsonData is Map<String, dynamic>) {
    // If jsonData is a Map, create a List with a single MarketCapModel
    return [MarketCapModel.fromJson(jsonData)];
  } else {
    throw FormatException("Invalid JSON format");
  }
}

String marketCapModelToJson(List<MarketCapModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MarketCapModel {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;
  int marketCap;
  int marketCapRank;
  int totalVolume;
  double high24H;
  double low24H;
  double priceChange24H;
  double priceChangePercentage24H;
  double marketCapChange24H;
  double marketCapChangePercentage24H;
  double circulatingSupply;
  double? totalSupply;
  double? maxSupply;
  double ath;
  double athChangePercentage;
  DateTime athDate;
  double atl;
  double atlChangePercentage;
  DateTime atlDate;
  Roi? roi;
  DateTime lastUpdated;
  double priceChangePercentage1HInCurrency;

  MarketCapModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.marketCapChange24H,
    required this.marketCapChangePercentage24H,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.roi,
    required this.lastUpdated,
    required this.priceChangePercentage1HInCurrency,
  });

  factory MarketCapModel.fromJson(Map<String, dynamic> json) => MarketCapModel(
        id: json["id"] ?? "",
        symbol: json["symbol"] ?? "",
        name: json["name"] ?? "",
        image: json["image"] ?? "",
        currentPrice: json["current_price"]?.toDouble() ?? 0.0,
        marketCap: json["market_cap"] ?? 0,
        marketCapRank: json["market_cap_rank"] ?? 0,
        totalVolume: json["total_volume"] ?? 0,
        high24H: json["high_24h"]?.toDouble() ?? 0.0,
        low24H: json["low_24h"]?.toDouble() ?? 0.0,
        priceChange24H: json["price_change_24h"]?.toDouble() ?? 0.0,
        priceChangePercentage24H:
            json["price_change_percentage_24h"]?.toDouble() ?? 0.0,
        marketCapChange24H: json["market_cap_change_24h"]?.toDouble() ?? 0.0,
        marketCapChangePercentage24H:
            json["market_cap_change_percentage_24h"]?.toDouble() ?? 0.0,
        circulatingSupply: json["circulating_supply"]?.toDouble() ?? 0.0,
        totalSupply: json["total_supply"]?.toDouble() ?? 0.0,
        maxSupply: json["max_supply"]?.toDouble() ?? 0.0,
        ath: json["ath"]?.toDouble() ?? 0.0,
        athChangePercentage: json["ath_change_percentage"]?.toDouble() ?? 0.0,
        athDate: json["ath_date"] != null
            ? DateTime.parse(json["ath_date"])
            : DateTime.now(),
        atl: json["atl"]?.toDouble() ?? 0.0,
        atlChangePercentage: json["atl_change_percentage"]?.toDouble() ?? 0.0,
        atlDate: json["atl_date"] != null
            ? DateTime.parse(json["atl_date"])
            : DateTime.now(),
        roi: json["roi"] == null ? null : Roi.fromJson(json["roi"]),
        lastUpdated: json["last_updated"] != null
            ? DateTime.parse(json["last_updated"])
            : DateTime.now(),
        priceChangePercentage1HInCurrency:
            json["price_change_percentage_1h_in_currency"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symbol": symbol,
        "name": name,
        "image": image,
        "current_price": currentPrice,
        "market_cap": marketCap,
        "market_cap_rank": marketCapRank,
        "total_volume": totalVolume,
        "high_24h": high24H,
        "low_24h": low24H,
        "price_change_24h": priceChange24H,
        "price_change_percentage_24h": priceChangePercentage24H,
        "market_cap_change_24h": marketCapChange24H,
        "market_cap_change_percentage_24h": marketCapChangePercentage24H,
        "circulating_supply": circulatingSupply,
        "total_supply": totalSupply,
        "max_supply": maxSupply,
        "ath": ath,
        "ath_change_percentage": athChangePercentage,
        "ath_date": athDate.toIso8601String(),
        "atl": atl,
        "atl_change_percentage": atlChangePercentage,
        "atl_date": atlDate.toIso8601String(),
        "roi": roi?.toJson(),
        "last_updated": lastUpdated.toIso8601String(),
        "price_change_percentage_1h_in_currency":
            priceChangePercentage1HInCurrency,
      };
}

class Roi {
  double times;
  Currency currency;
  double percentage;

  Roi({
    required this.times,
    required this.currency,
    required this.percentage,
  });

  factory Roi.fromJson(Map<String, dynamic> json) => Roi(
        times: json["times"]?.toDouble(),
        currency: currencyValues.map[json["currency"]]!,
        percentage: json["percentage"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "times": times,
        "currency": currencyValues.reverse[currency],
        "percentage": percentage,
      };
}

enum Currency { BTC, ETH, USD }

final currencyValues =
    EnumValues({"btc": Currency.BTC, "eth": Currency.ETH, "usd": Currency.USD});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
