import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:movie_app/models/movie_model.dart';

class ApiService {
  final apiKey = "api_key=89fc319f19a1b206e2ba795e0640625f";
  final popularMovies = "https://api.themoviedb.org/3/movie/popular?";

  Future<void> getPopularMovies()async{
    final response = await http.get(Uri.parse('$popularMovies$apiKey'));
    if (response.statusCode== 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body['results'];
      List<MovieModel> movies = [];
      Logger().f(results.length);
    } else {
      Logger().e('Error - ${response.statusCode}');
    }
  }
}
