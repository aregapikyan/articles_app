import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_articles/models/model_article_widget.dart';
import 'package:flutter_app_articles/repos/repo_articles.dart';
import 'package:flutter_app_articles/screens/base_state/base_articles_state.dart';
import 'package:flutter_app_articles/widgets/widget_article.dart';
import 'package:flutter_app_articles/widgets/widget_dissmissed_background.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:get/get.dart';

class ScreenArticles extends StatefulWidget {
  @override
  _ScreenArticlesState createState() => _ScreenArticlesState();
}

class _ScreenArticlesState extends BaseArticlesState<ScreenArticles> {
  Timer _searchDebounce;
  SearchBar _searchBar;
  final _searchTextController = TextEditingController();

  _ScreenArticlesState() {
    _searchBar = new SearchBar(
      inBar: false,
      controller: _searchTextController,
      setState: setState,
      onSubmitted: _searchQuery(),
      buildDefaultAppBar: buildAppBar,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        'Articles',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      actions: [_searchBar.getSearchAction(context)],
    );
  }

  _searchQuery() {
    if (_searchDebounce?.isActive == false) _searchDebounce.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 1000), () {
      List<ModelArticle> queryList = articlesRepo.filterModels((element) {
        return element.title.contains(_searchTextController.text) ||
            element.description.contains(_searchTextController.text);
      });
      setState(() {
        articleModels.clear();
        articleModels.addAll(queryList);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(_searchQuery);
  }

  @override
  void dispose() {
    _searchTextController.removeListener(_searchQuery);
    _searchTextController.dispose();
    _searchDebounce.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  AppBar get appBar => _searchBar.build(context);

  @override
  Stream<List<ModelArticle>> get stream =>
      articlesRepo.articlesStreamController.stream;

  @override
  String get noDataText => 'No Articles To Show';

  @override
  Future<dynamic> fetchData() {
    return articlesRepo.fetchArticles();
  }

  @override
  void doOnDismissed(int id) {
    articlesRepo.removeArticle(id);
  }

}
