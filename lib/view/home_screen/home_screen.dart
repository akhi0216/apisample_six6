// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:apisample_six6/controller/homescreencontroller.dart';
import 'package:apisample_six6/view/home_screen/customnewscard.dart';
import 'package:apisample_six6/view/home_screen/search_screen/search_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<Homescreencontroller>(context, listen: false)
          .fetchNewsbyCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerObj = Provider.of<Homescreencontroller>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "NEWS APP",
            style: TextStyle(color: Colors.red),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ));
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ))
          ],
        ),
        body: Column(
          children: [
            //  CarouselSlider(items: List.generate(providerObj.topheadlinesList.length,
            //  (index) => Container(
            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.green),
            //   child: ClipRRect(
            //    borderRadius: BorderRadius.circular(12),
            //   ),
            //  )),
            //  options: options),
            CarouselSlider(
              options: CarouselOptions(
                height: 300,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInToLinear,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
              items: List.generate(
                  providerObj.topheadlinesList.length,
                  (index) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: providerObj
                                    .topheadlinesList[index].urlToImage ??
                                "",
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      )),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    Homescreencontroller.categoryList.length,
                    (index) => InkWell(
                          onTap: () async {
                            await Provider.of<Homescreencontroller>(context,
                                    listen: false)
                                .fetchNewsbyCategory(
                                    index: index,
                                    category: Homescreencontroller
                                        .categoryList[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.red.withOpacity(.2),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            child: Text(
                              Homescreencontroller.categoryList[index],
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
              ),
            ),
            Expanded(
              child: providerObj.isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      itemCount: providerObj.articles.length,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      itemBuilder: (context, index) => CustomNewsCard(
                        imageUrl: providerObj.articles[index].urlToImage ?? "",
                        author: providerObj.articles[index].author ?? "",
                        category:
                            providerObj.articles[index].source?.name ?? "",
                        title: providerObj.articles[index].title ?? "",
                        dateTime: DateFormat("dd MMM yyyy ")
                            .format(providerObj.articles[index].publishedAt!),
                      ),
                      separatorBuilder: (context, index) => Divider(
                        thickness: .5,
                        // indent: 30,
                        // endIndent: 30,
                      ),
                    ),
            ),
          ],
        ));
  }
}
