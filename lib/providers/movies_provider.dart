import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/helpers/debouncer.dart';
import 'package:movie_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '97e5078de8dd70ceb2de3b8942820221';
  final String _language = 'es-ES';
  int _popularPage = 0;
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  bool _isLoading = false;

  Map<int, List<Cast>> movieCast = {};
  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionsStreamController =
      StreamController<List<Movie>>.broadcast();

  Stream<List<Movie>> get suggestionsStream =>
      _suggestionsStreamController.stream;

  MoviesProvider() {
    getDisplayMovies();
    getPopularMovies();
    // _suggestionsStreamController.close();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, '/3/movie/$endpoint', {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });

    final resp = await http.get(url);
    return resp.body;
  }

  void getDisplayMovies() async {
    final jsonData = await _getJsonData('now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  void getPopularMovies() async {
    if (_isLoading) return;
    _isLoading = true;
    _popularPage++;
    final jsonData = await _getJsonData('popular', _popularPage);
    final popularMoviesResponse = PopularMoviesResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularMoviesResponse.results];
    _isLoading = false;
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId] as List<Cast>;

    final jsonData = await _getJsonData('$movieId/credits');
    final movieCreditsResponse = CreditsResponse.fromJson(jsonData);
    movieCast[movieId] = movieCreditsResponse.cast;
    return movieCreditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '/3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    final resp = await http.get(url);
    final searchMoviesResponse = SearchMoviesResponse.fromJson(resp.body);

    return searchMoviesResponse.results;
  }

  void searchMoviesDebounced(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final movies = await searchMovies(query);
      _suggestionsStreamController.sink.add(movies);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 301), () {
      timer.cancel();
    });
  }
}
