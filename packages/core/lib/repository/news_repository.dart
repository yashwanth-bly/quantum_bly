import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<NewsResponse> getNews() async {
    const newsAPI =
        'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=5e02191b32294a91be4a0fa4edd0cf1f';
    final response = await http.get(Uri.parse(newsAPI));
    return NewsResponse.fromJson(jsonDecode(response.body));
  }
}
