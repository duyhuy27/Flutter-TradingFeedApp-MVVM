import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:trading_news/model/news/news_model.dart';
import 'package:trading_news/model/news/search_news_models.dart';
import 'package:trading_news/widget/dialog_error.dart';

class NewsRepository {
  final Map<String, NewsLatestModel> _cachedNewsLatestMap = {};
  final Map<String, SearchNewsModel> _cachedSearchMap = {};
  Future<NewsLatestModel> fetchNewsLatest(
      String category, BuildContext context) async {
    // Kiểm tra xem dữ liệu đã được lưu trữ cho category này chưa
    if (_cachedNewsLatestMap.containsKey(category)) {
      // Trả về dữ liệu đã lưu trữ cho category này
      return _cachedNewsLatestMap[category]!;
    }

    String url =
        'https://min-api.cryptocompare.com/data/v2/news/?categories=$category&lang=EN';

    try {
      final response = await http.get(Uri.parse(url));

      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final newsLatestModel = NewsLatestModel.fromJson(body);
        // Cập nhật dữ liệu đã lưu trữ cho category này
        _cachedNewsLatestMap[category] = newsLatestModel;
        return newsLatestModel;
      } else if (response.statusCode == 429) {
        print('rate time limit');
        showNoConnectionDialog(
            context, 'API rate limit exceeded. Please try again later.');
      } else {
        showNoConnectionDialog(
            context, 'Failed to fetch news data. Please try again later.');
      }
    } catch (e) {
      print('Network error: $e');
      showNoConnectionDialog(
          context, 'Network error. Please check your internet connection.');
    }

    throw Exception('Error');
  }

  Future<SearchNewsModel> fetchResultSearch(
      String q, BuildContext context) async {
    String url =
        'https://newsapi.org/v2/everything?q=$q&apiKey=e49b88129320460ea7121d1c4b2072b1';

    try {
      final response = await http.get(Uri.parse(url));

      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final newsLatestModel = SearchNewsModel.fromJson(body);
        // Cập nhật dữ liệu đã lưu trữ cho category này

        return newsLatestModel;
      } else if (response.statusCode == 429) {
        print('rate time limit');
        showNoConnectionDialog(
            context, 'API rate limit exceeded. Please try again later.');
      } else {
        showNoConnectionDialog(
            context, 'Failed to fetch news data. Please try again later.');
      }
    } catch (e) {
      print('Network error: $e');
      showNoConnectionDialog(
          context, 'Network error. Please check your internet connection.');
    }

    throw Exception('Error');
  }
}
