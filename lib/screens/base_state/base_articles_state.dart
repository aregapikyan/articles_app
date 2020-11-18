import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_articles/models/model_article_widget.dart';
import 'package:flutter_app_articles/repos/repo_articles.dart';
import 'package:flutter_app_articles/utils/article_details_result_type.dart';
import 'package:flutter_app_articles/widgets/widget_article.dart';
import 'package:flutter_app_articles/widgets/widget_dissmissed_background.dart';
import 'package:get/get.dart';

import '../screen_article_details.dart';

abstract class BaseArticlesState<T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {
  // Fixme write methods after fields
  Future<dynamic> fetchData();

  void doOnDismissed(int id) {}
  AppBar appBar;
  Stream<List<ModelArticle>> stream;
  ArticlesRepo articlesRepo;
  String noDataText;

  List<ModelArticle> articleModels;

  BaseArticlesState() {
    articlesRepo = ArticlesRepo();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  bool get wantKeepAlive => true;

  // Fixme call super.build(context)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: RefreshIndicator(
          onRefresh: () {
            return fetchData();
          },
          child: StreamBuilder<List<ModelArticle>>(
            stream: stream,
            builder: (BuildContext context,
                AsyncSnapshot<List<ModelArticle>> snapshot) {
              if (snapshot.hasData) {
                articleModels = snapshot.data;
                return _content();
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ));
              }
            },
          )),
    );
  }

  Widget _content() {
    if (articleModels.isEmpty) {
      // Fixme place empty result inside list view
      return Center(
        child: Text(
          noDataText,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    } else {
      return ListView.builder(
          itemBuilder: (context, index) {
            return Dismissible(
                background: DismissedBackground(),
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  setState(() {
                    var initialId = articleModels[index].id;
                    articleModels.removeAt(index);
                    doOnDismissed(initialId);
                  });
                },
                child: InkWell(
                  child: WidgetArticle(articleModels[index]),
                  onTap: () => _openArticleDetails(context,
                      articlesRepo.findInitialArticle(articleModels[index].id)),
                ));
          },
          itemCount: articleModels.length);
    }
  }

  _openArticleDetails(BuildContext context, ModelArticle article) async {
    final bool hasBookmarkChanged = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return ScreenArticleDetails(article, article.bookmarked);
    }));
    if (hasBookmarkChanged ?? false) {
      articlesRepo.writeBookmarks(shouldRead: hasBookmarkChanged);
    }
  }
}
