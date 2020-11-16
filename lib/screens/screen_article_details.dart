import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_articles/models/model_article_widget.dart';
import 'package:flutter_app_articles/repos/repo_articles.dart';
import 'package:flutter_app_articles/screen_content/content_article_details.dart';
import 'package:flutter_app_articles/utils/article_details_result_type.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenArticleDetails extends StatefulWidget {
  static final routeKey = '/screen_article_details';
  final ModelArticle _articleModel;
  final bool isBookmarked;

  ScreenArticleDetails(this._articleModel, this.isBookmarked);

  @override
  _ScreenArticleDetailsState createState() => _ScreenArticleDetailsState();
}

class _ScreenArticleDetailsState extends State<ScreenArticleDetails> {

  void _handleClick(String value) {
    if (value == 'Share') {
      _launchMailURL('xxx@gmail.com', widget._articleModel.title,
          widget._articleModel.description);
    } else {
      widget._articleModel.bookmarked = false;
      setState(() {});
    }
  }

  void _addBookmark() {
    widget._articleModel.bookmarked = true;
    setState(() {});
  }

  void _onClosePressed(BuildContext context) {
    bool hasBookmarkChanged =
        widget._articleModel.bookmarked != widget.isBookmarked;

    Navigator.pop(context, hasBookmarkChanged);
  }

  void _launchMailURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          child: IconButton(
            icon: Icon(Icons.close),
            color: Colors.black,
            onPressed: () {
              _onClosePressed(context);
            },
          ),
        ),
        actions: [
          if (!widget._articleModel.bookmarked)
            IconButton(
              icon: Icon(Icons.bookmark_border),
              color: Colors.black,
              onPressed: () {
                _addBookmark();
              },
            ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: _handleClick,
            itemBuilder: (BuildContext context) {
              return {'Share', 'Remove'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ContentArticleDetails(widget._articleModel),
    );
  }
}
