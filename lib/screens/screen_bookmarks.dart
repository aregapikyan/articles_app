import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_articles/models/model_article_widget.dart';
import 'package:flutter_app_articles/repos/repo_articles.dart';
import 'package:flutter_app_articles/screens/base_state/base_articles_state.dart';
import 'package:get/get.dart';

class ScreenBookmarks extends StatefulWidget {
  @override
  _ScreenBookmarksState createState() => _ScreenBookmarksState();
}

class _ScreenBookmarksState extends BaseArticlesState<ScreenBookmarks> {

  @override
  AppBar get appBar => AppBar(
    title: Text(
      'Bookmarks',
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.white,
  );

  @override
  Stream<List<ModelArticle>> get stream => articlesRepo.bookmarksStreamController.stream;

  @override
  String get noDataText => 'No Bookmarks To Show';

  @override
    Future<dynamic> fetchData() {
      return articlesRepo.readBookmarks();
  }

  @override
  void doOnDismissed(int id) {
    articlesRepo.findInitialArticle(id).bookmarked = false;
  }

}
