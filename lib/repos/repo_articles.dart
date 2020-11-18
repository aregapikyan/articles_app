import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_articles/models/model_article_widget.dart';
import 'package:flutter_app_articles/utils/article_details_result_type.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ArticlesRepo {
  static final ArticlesRepo _articlesRepo = ArticlesRepo._internal();

  factory ArticlesRepo() {
    return _articlesRepo;
  }

  ArticlesRepo._internal();

  List<ModelArticle> _initialArticleModels = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/article_bookmarks.txt');
  }

  var articlesStreamController = StreamController<List<ModelArticle>>();
  var bookmarksStreamController = StreamController<List<ModelArticle>>();

  Future<List<ModelArticle>> _getArticles() async {
    final jsonResponse = await http.get('https://jsonkeeper.com/b/3FE1');
    final response = json.decode(jsonResponse.body)['articles'] as List;
    return response
        .map((articleJson) => ModelArticle.fromJson(articleJson))
        .toList();
  }

  Future<void> fetchArticles() async {
    var models = await _getArticles();
    var shouldRead = _initialArticleModels.isNotEmpty;
    _initialArticleModels = [...models];
    articlesStreamController.add(models);
    writeBookmarks(shouldRead: shouldRead);
  }

  Future<List<ModelArticle>> readBookmarks() async {
    try {
      final file = await _localFile;
      String bookmarksJson = await file.readAsString();
      List<ModelArticle> bookmarks = (json.decode(bookmarksJson) as List)
          .map((articleJson) => ModelArticle.fromJson(articleJson))
          .toList();
      bookmarksStreamController.add(bookmarks);
      return bookmarks;
    } catch (e) {
      return null;
    }
  }

  // Fixme better to always specify the return type
  writeBookmarks({bool shouldRead = false}) async {
    final file = await _localFile;
    List<ModelArticle> bookmarks = _filteredBookmarks();
    String bookmarksJson;
    bookmarksJson = jsonEncode(bookmarks);
    file.writeAsString(bookmarksJson);
    if (shouldRead) {
      readBookmarks();
    }
  }

  List<ModelArticle> _filteredBookmarks() {
    List<ModelArticle> bookmarks;
    bookmarks = _initialArticleModels.where((element) {
      return element.bookmarked;
    }).toList();
    return bookmarks;
  }

  ModelArticle findInitialArticle(int id) {
    return _initialArticleModels.where((element) {
      return element.id == id;
    }).first;
  }

  void removeArticle(int id) {
    var model = findInitialArticle(id);
    _initialArticleModels.remove(model);
    if (model.bookmarked) {
      writeBookmarks(shouldRead: true);
    }
  }

  List<ModelArticle> filterModels(bool test(ModelArticle element)) {
    return _initialArticleModels.where(test).toList();
  }
}
