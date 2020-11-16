import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_articles/models/model_article_widget.dart';
import 'package:flutter_app_articles/screens/screen_articles.dart';
import 'package:flutter_app_articles/screens/screen_bookmarks.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:get/get.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  final List<Widget> pages = [ScreenArticles(), ScreenBookmarks()];
  final _pageController = PageController(initialPage: 0, keepPage: true);

  _selectPage(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey.shade400,
        selectedItemColor: Colors.black,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined), label: 'Articles'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border), label: 'Bookmarks')
        ],
      ),
    );
  }
}
