import 'dart:convert';

import 'package:apisample_six6/model/samplemodelapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homescreencontroller with ChangeNotifier {
  bool isLoading = false;
  bool categoryLoading = false;
  bool topHeadlinesLoading = false;
  List<Article> articles = [];
  List<Article> topheadlinesList = [];
  static int? selectedIndex;
  static List<String> categoryList = [
    "business",
    "entertainment",
    "general",
    "health",
    "sports",
    "science",
    "technology"
  ];
//

//
  // fetchData() async {
  //   isLoading = true;
  //   notifyListeners();
  //   final url = Uri.parse(
  //       "https://newsapi.org/v2/everything?q=bbc&sortBy=popularity&apiKey=32585670fe2a457b9e2840c6504cc029");
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var decodedData = jsonDecode(response.body);
  //     SampleApiResmodel resmodel = SampleApiResmodel.fromJson(decodedData);
  //     articles = resmodel.articles ?? [];
  //   }
  //   isLoading = false;
  //   notifyListeners();
  // }

  fetchNewsbyCategory({String category = "business", int index = 0}) async {
    selectedIndex = index;
    notifyListeners();
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=de&category=$category&apiKey=32585670fe2a457b9e2840c6504cc029");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      SampleApiResmodel resmodel = SampleApiResmodel.fromJson(decodedData);
      articles = resmodel.articles ?? [];
    }
    isLoading = false;
    notifyListeners();
  }

  // topHeadLines() {
  //   final url = Uri.parse(
  //       "https://newsapi.org/v2/top-headlines?country=in&apiKey=32585670fe2a457b9e2840c6504cc029");

  // }
  getTopHeadlines() async {
    topHeadlinesLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=742488509a4f4f23b93e7ac3afc24cad");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedRes = jsonDecode(response.body);
      SampleApiResmodel resModel = SampleApiResmodel.fromJson(decodedRes);
      topheadlinesList = resModel.articles ?? [];
    }
    topHeadlinesLoading = false;
    notifyListeners();
  }
}
