
import 'package:flutter/material.dart';
import 'package:trading_news/model/news/news_model.dart';
import 'package:trading_news/res/news_res.dart';

class NewsViewModel {
  final _rep = NewsRepository();
  Future<NewsLatestModel> fetchNewsLatest(String category,BuildContext context) async {
    final reponse = await _rep.fetchNewsLatest(category, context);
    return reponse;
  }
}
