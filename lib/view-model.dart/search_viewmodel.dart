import 'package:flutter/material.dart';
import 'package:trading_news/model/news/news_model.dart';
import 'package:trading_news/model/news/search_news_models.dart';
import 'package:trading_news/res/news_res.dart';

class SearchViewModel {
  final _rep = NewsRepository();
  Future<SearchNewsModel> fetchResultSearch(
      String q, BuildContext context) async {
    final reponse = await _rep.fetchResultSearch(q, context);
    return reponse;
  }
}
