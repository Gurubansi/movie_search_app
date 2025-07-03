import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_search_app/services/models/popular_movie_model.dart';
import 'package:movie_search_app/services/models/search_result_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  List<PopularMovies> _movieList = [];
  List<Results> _searchMovieList = [];
  List<String> _recentSearches = [];
  bool _isLoading = false;
  bool isSearching = false;
  String? _errorMessage;

  List<PopularMovies> get movieList => _movieList;
  List<Results> get searchList => _searchMovieList;
  List<String> get recentSearches => _recentSearches;
  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  final String _apiKey = 'dc3f147bcbmshc827b09c2061ceap124580jsnb75350ef5dfa';
  final String _apiHost = 'imdb236.p.rapidapi.com';

  void onSearch()async{
    if(searchController.text.trim().isNotEmpty){
      isSearching = true;
      notifyListeners();
    }
    await searchMovies(searchController.text);
  }
  // Fetch popular movies
   fetchPopularMovies() async {
    _isLoading = true;
    _errorMessage = null;
    _movieList = [];
    notifyListeners();

    try {
      final url = Uri.parse('https://imdb236.p.rapidapi.com/api/imdb/most-popular-movies');
      final response = await http.get(url, headers: {
        'x-rapidapi-key': _apiKey,
        'x-rapidapi-host': _apiHost,
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _movieList = (data as List)
            .map((json) => PopularMovies.fromJson(json))
            .toList();
      } else {
        _errorMessage = 'Failed to load movies: ${response.statusCode}';
        _movieList = [];
      }
    } catch (e) {
      _errorMessage = 'Error fetching movies: $e';
      _movieList = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Search movies by title
   searchMovies(String query) async {
    if (query.isEmpty) return;

    _isLoading = true;
    _errorMessage = null;
    _searchMovieList = [];
    notifyListeners();

    try {
      final url = Uri.parse(
          'https://$_apiHost/api/imdb/search?originalTitle=$query&type=movie');
      final response = await http.get(url, headers: {
        'x-rapidapi-key': _apiKey,
        'x-rapidapi-host': _apiHost,
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _searchMovieList = (data['results'] as List)
            .map((json) => Results.fromJson(json))
            .toList();
        await _addRecentSearch(query);
      } else {
        _errorMessage = 'Failed to load search results: ${response.statusCode}';
        _searchMovieList = [];
      }
    } catch (e) {
      _errorMessage = 'Error searching movies: $e';
      _searchMovieList = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // // Load recent searches from SharedPreferences
   loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    _recentSearches = prefs.getStringList('recentSearches') ?? [];
    notifyListeners();
  }
  onRecentSearchTap(String value) async {
    if(value.isNotEmpty){
      searchController.text = value;
      isSearching = true;
      notifyListeners();
      await searchMovies(value);
    }
  }
  removeRecent(int index)async{
    _recentSearches.removeAt(index);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('recentSearches', _recentSearches);
    notifyListeners();
  }


  // Add a search query to recent searches
   _addRecentSearch(String query) async {
    if (!_recentSearches.contains(query)) {
      _recentSearches.insert(0, query);
      if (_recentSearches.length > 5) _recentSearches.removeLast();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('recentSearches', _recentSearches);
      notifyListeners();
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}