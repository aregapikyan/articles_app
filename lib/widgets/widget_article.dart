import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_articles/models/model_article_widget.dart';
import 'package:flutter_app_articles/screens/screen_article_details.dart';
import 'package:flutter_app_articles/widgets/widget_images.dart';
import 'package:flutter_app_articles/widgets/widget_user_image.dart';

class WidgetArticle extends StatelessWidget {
  final ModelArticle article;

  const WidgetArticle(this.article);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${article.userName} - ${article.elapsedTimeInHour} hours ago',
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          article.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  UserImage(article.userImage)
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                article.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12),
              ),
              if (article.images.isNotEmpty) WidgetImages(article.images)
            ],
          ),
        ),
        Container(
          height: 4,
          color: Colors.grey.shade200,
        )
      ],
    );
  }
}
