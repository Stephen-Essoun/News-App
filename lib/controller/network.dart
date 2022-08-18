
import 'package:all_news/model/api.dart';
import 'package:http/http.dart';
 
class Network {
  String newsApiUrl =
      "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=54d9339efa2d4e419e61ff0f8158b581";

  Future<NewsApi> getNews() async {
    final response = await get(Uri.parse(newsApiUrl));

    if (response.statusCode == 200) {
      return newsApiFromJson(response.body);
    } else {
      throw {
        Exception("Failed to get data from $newsApiUrl")
      };
    }
  }
}
