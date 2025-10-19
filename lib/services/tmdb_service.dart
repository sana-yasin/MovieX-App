import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

///the Movie DataBase = TMBD
class TMDBService {
  // TODO: Replace with your actual TMDB API key
  static const String _apiKey = '0e985865b8bc40afc0221aee95c019df';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  // Get Now Playing Movies
  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_baseUrl/movie/now_playing?api_key=$_apiKey&language=en-US&page=1'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load now playing movies');
      }
    } catch (e) {
      print('Error fetching now playing movies: $e');
      return [];
    }
  }

  // Get Upcoming Movies (Coming Soon)
  Future<List<Movie>> getUpcomingMovies() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_baseUrl/movie/upcoming?api_key=$_apiKey&language=en-US&page=1'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load upcoming movies');
      }
    } catch (e) {
      print('Error fetching upcoming movies: $e');
      return [];
    }
  }

  // Get Popular Movies (for banner)
  Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_baseUrl/movie/popular?api_key=$_apiKey&language=en-US&page=1'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load popular movies');
      }
    } catch (e) {
      print('Error fetching popular movies: $e');
      return [];
    }
  }

  // Search Movies
  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_baseUrl/search/movie?api_key=$_apiKey&language=en-US&query=$query&page=1'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search movies');
      }
    } catch (e) {
      print('Error searching movies: $e');
      return [];
    }
  }
}
