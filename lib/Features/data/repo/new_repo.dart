import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:news/Features/data/model/news_model.dart';
import 'package:news/core/Errors/failure.dart';
import 'package:news/core/Network/network.dart';
import 'package:news/core/utils/constant.dart';
import 'package:news/core/utils/parser.dart';

class NewsRepo with Parser {
  static Future<(Failure?, Article?)> getArticle() async {
    NetworkServiceImpl networkServiceImpl =
        NetworkServiceImpl(InternetConnectionCheckerPlus(), APIInfo());
    final res = await networkServiceImpl.get(
        endpoint: '/everything',
        headers: {'X-Api-Key': networkServiceImpl.apiInfo.apiKey},
        query: {'q': 'bitcoin'});

    if (res.$1 != null) {
      return (res.$1, null);
    }
    Article article = Article.fromJson(res.$2 ?? {});
    return (null, article);
  }
}
