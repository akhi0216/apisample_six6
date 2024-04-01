// ignore_for_file: prefer_const_constructors

import 'package:apisample_six6/controller/searchscreencontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provObject = Provider.of<SearchScreenController>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                suffixIcon: InkWell(
                    onTap: () {
                      if (searchcontroller.text.isNotEmpty) {
                        Provider.of<SearchScreenController>(context,
                                listen: false)
                            .searchNews(query: searchcontroller.text);
                      }
                    },
                    child: Icon(Icons.search))),
            controller: searchcontroller,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: provObject.searchedArticles.length,
            itemBuilder: (context, index) =>
                Text(provObject.searchedArticles[index].title.toString()),
          ))
        ],
      ),
    );
  }
}
