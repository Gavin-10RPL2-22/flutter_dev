import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dev/model/model.dart';
import 'package:flutter_dev/model/modelNews.dart';
import 'package:flutter_dev/model/modelTop.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  modelNews? _news;
  modelTopNews? _topNews;
  modelNewsStreet? _newsStreet;
  bool _isLoad = false;
  List<Articles> _articles = [];
  List<TopArticles> _toparticles = [];
  List<ArticlesStreet> _streetarticle = [];

  getNews() async {
    setState(() {
      _isLoad = true;
    });
    final res = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=478cb4033cc5465ab557702f166668bd"));
    _news = modelNews.fromJson(json.decode(res.body.toString()));
    _articles = _news!.articles!;
    setState(() {
      _isLoad = false;
    });
  }

  getStreetNews() async {
    setState(() {
      _isLoad = true;
    });
    final res = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=478cb4033cc5465ab557702f166668bd"));
    _newsStreet = modelNewsStreet.fromJson(json.decode(res.body.toString()));
    _streetarticle = _newsStreet!.articles!;
    print("DATA :" + _streetarticle.length.toString());
    setState(() {
      _isLoad = false;
    });
  }

  getTopNews() async {
    setState(() {
      _isLoad = true;
    });
    final res = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=478cb4033cc5465ab557702f166668bd"));
    _topNews = modelTopNews.fromJson(json.decode(res.body.toString()));
    _toparticles = _topNews!.articles!;
    setState(() {
      _isLoad = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
    getTopNews();
    getStreetNews();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: _isLoad
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 37,
                  ),
                  Text(
                    "Goal Planner",
                    style: GoogleFonts.assistant(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 180,
                          child: Image.asset(
                            "assets/images/img.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "Cari tahu portofolio yang\n sesuai dengan tujuan \ninvestasimu",
                              style: GoogleFonts.assistant(fontSize: 14),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Container(
                              width: 140,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => HomePage())));
                                },
                                child: Text("Masuk"),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFF3266CC))),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    color: Colors.white,
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 25, left: 25, top: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Reksa Dana Kami",
                                  style: GoogleFonts.assistant(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                Container(
                                  width: 80,
                                  height: 22,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Color(0xFFF6FCD8),
                                  ),
                                  child: Text(
                                    "Lihat Semua",
                                    style: GoogleFonts.assistant(
                                        fontSize: 12,
                                        color: Color(0xFF89B129),
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Container(
                              height: 150,
                              child: ListView.builder(
                                itemCount: _toparticles.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      await launchUrl(Uri.parse(
                                          _toparticles[index].url.toString()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 16),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              _toparticles[index]
                                                  .urlToImage
                                                  .toString(),
                                              height: 100,
                                              fit: BoxFit.fill,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                    child: Image.asset(
                                                        "assets/images/list1.png"));
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            width: 200,
                                            child: Text(
                                              _toparticles[index]
                                                  .title
                                                  .toString(),
                                              style: GoogleFonts.assistant(
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Artikel",
                                  style: GoogleFonts.assistant(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                Container(
                                  width: 80,
                                  height: 22,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Color(0xFFF6FCD8),
                                  ),
                                  child: Text(
                                    "Lihat Semua",
                                    style: GoogleFonts.assistant(
                                        fontSize: 12,
                                        color: Color(0xFF89B129),
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 240,
                              child: ListView.builder(
                                itemCount: _articles.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      await launchUrl(Uri.parse(
                                          _articles[index].url.toString()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              _articles[index]
                                                  .urlToImage
                                                  .toString(),
                                              height: 125,
                                              fit: BoxFit.fill,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                    child: Image.asset(
                                                        "assets/images/list2.png"));
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            width: 200,
                                            child: Text(
                                              _articles[index].title.toString(),
                                              style: GoogleFonts.assistant(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            width: 200,
                                            child: Text(
                                              _articles[index]
                                                  .description
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.assistant(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12),
                                              maxLines: 3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 26,
                            ),
                            Text(
                              'FAQ',
                              style: GoogleFonts.assistant(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            ExpansionPanelList(
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  _streetarticle[index].isExpanded =
                                      !isExpanded;
                                });
                              },
                              children: _streetarticle
                                  .map<ExpansionPanel>((ArticlesStreet item) {
                                return ExpansionPanel(
                                  canTapOnHeader: true,
                                  isExpanded: item.isExpanded!,
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return ListTile(
                                      title: Text(
                                        item.title.toString(),
                                        style: GoogleFonts.assistant(
                                            color: Color(0xFF091C61)),
                                      ),
                                    );
                                  },
                                  body: ListTile(
                                    title: Text(
                                      item.description.toString(),
                                      style: GoogleFonts.assistant(),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Licensed By',
                              style: GoogleFonts.assistant(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child:
                                      Image.asset("assets/logo/license1.png"),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  child:
                                      Image.asset("assets/logo/license2.png"),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    ));
  }
}
