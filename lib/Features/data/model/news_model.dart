import 'package:news/Features/data/model/news_item_model.dart';

class Article {
  String status;
  int totalResults;
  List<ArticleItem> articles;

  Article(
      {required this.status,
      required this.totalResults,
      required this.articles});

  factory Article.fromJson(Map<String, dynamic> json) {
    var articlesList = json['articles'] as List;
    List<ArticleItem> articles =
        articlesList.map((i) => ArticleItem.fromJson(i)).toList();

    return Article(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: articles,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles.map((article) => article.toJson()).toList(),
    };
  }
}
