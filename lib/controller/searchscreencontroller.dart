import 'dart:convert';

import 'package:apisample_six6/model/samplemodelapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreenController with ChangeNotifier {
  bool isLoading = false;
  // bool categoryLoading = false;
  // bool topHeadlinesLoading = false;
  List<Article> searchedArticles = [];

  searchNews({required String query}) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$query&sortBy=popularity&apiKey=32585670fe2a457b9e2840c6504cc029");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      SampleApiResmodel resmodel = SampleApiResmodel.fromJson(decodedData);
      searchedArticles = resmodel.articles ?? [];
    }
    isLoading = false;
    notifyListeners();
  }
}
