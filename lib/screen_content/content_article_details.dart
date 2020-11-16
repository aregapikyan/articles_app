import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_articles/models/model_article_widget.dart';
import 'package:flutter_app_articles/widgets/widget_grid_images.dart';
import 'package:flutter_app_articles/widgets/widget_user_image.dart';

class ContentArticleDetails extends StatelessWidget {
  final ModelArticle article;

  ContentArticleDetails(this.article);

  List<Widget> _sliverListContent() {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(
            article.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Text(
                    '${article.userName} - ${article
                        .elapsedTimeInHour} hours ago',
                    style:
                    TextStyle(fontSize: 14, color: Colors.grey.shade400)),
              ),
              UserImage(article.userImage)
            ],
          ),
          SizedBox(height: 10,),
          Text(article.description,
              style: TextStyle(
                fontSize: 14,
              )),
          SizedBox(
            height: 20,
          )
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CustomScrollView(slivers: [
        SliverList(
            delegate: SliverChildListDelegate.fixed(_sliverListContent())),
        SliverGrid(
            delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
              return Image.network(
                article.images[index],
                fit: BoxFit.cover,
              );
            }, childCount: article.images.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10))
      ]),
    );
  }
}
