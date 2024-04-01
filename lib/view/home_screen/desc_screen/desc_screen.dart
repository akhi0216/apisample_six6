// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:html';

import 'package:apisample_six6/model/samplemodelapi.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DescScreen extends StatefulWidget {
  const DescScreen({super.key, required this.selectedArticles});
  final Article selectedArticles;
  @override
  State<DescScreen> createState() => _DescScreenState();
}

class _DescScreenState extends State<DescScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(
            Icons.bookmark,
            color: Colors.black,
          ),
          Icon(Icons.more_vert)
        ],
      ),
      body: Column(
        children: [
          Text(widget.selectedArticles.title.toString()),
          CachedNetworkImage(
              height: 300,
              fit: BoxFit.cover,
              imageUrl: widget.selectedArticles.urlToImage.toString()),
          Text(widget.selectedArticles.content.toString()),
          TextButton(
              onPressed: () async {
                final url = Uri.parse(widget.selectedArticles.url.toString());
                await launchUrl(url);
              },
              child: Text("read more"))
        ],
      ),
    );
  }
}
