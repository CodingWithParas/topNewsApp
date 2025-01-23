// lib/services/news_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  // Directly enter your API key here (not recommended for production)
  final String _apiKey = 'd4b9b165ba08487f8978646ec283a315';  // Your NewsAPI key
  final String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<Article>> fetchTopHeadlines(String country) async {
    final response = await http.get(Uri.parse('$_baseUrl?country=$country&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['articles'];
      return data.map((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}

class Article {
  final String title;
  final String description;
  final String urlToImage;
  final String url;

  Article({required this.title, required this.description, required this.urlToImage, required this.url});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? "No Title",
      description: json['description'] ?? "No Description",
      urlToImage: json['urlToImage'] ?? '',
      url: json['url'] ?? "",
    );
  }
}
