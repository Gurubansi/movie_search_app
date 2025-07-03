import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_search_app/services/models/popular_movie_model.dart';
import 'package:movie_search_app/services/models/search_result_model.dart';
import 'package:movie_search_app/services/providers/movie_provider.dart';
import 'package:movie_search_app/utils/app_color.dart';
import 'dart:io' show Platform;

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MovieProvider>(context, listen: false);
     // provider.fetchPopularMovies();
      provider.loadRecentSearches();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Platform.isIOS
        ? CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Movies', style: TextStyle(color:  AppColor.accentYellow)),
        backgroundColor: AppColor.backgroundDark,
      ),
      child: Container(
        color: AppColor.backgroundDark,
        child: SafeArea(
          child: _buildContent(context, screenSize),
        ),
      ),
    )
        : Scaffold(
      appBar: AppBar(
        title: const Text('Movies', style: TextStyle(color: AppColor.accentYellow)),
        backgroundColor:AppColor.backgroundDark, 
      ),
      backgroundColor:AppColor.backgroundDark,
      body: _buildContent(context, screenSize),
    );
  }

  Widget _buildContent(BuildContext context, Size screenSize) {
    return Column(
      children: [
        Consumer<MovieProvider>(builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Platform.isIOS
                    ? CupertinoSearchTextField(
                  controller: provider.searchController,
                  placeholder: 'Search movies',
                  placeholderStyle: const TextStyle(color: AppColor.secondaryText),
                  backgroundColor: AppColor.secondaryText[900],
                  borderRadius: BorderRadius.circular(25),
                  prefixIcon: const Icon(Icons.search, color:  AppColor.accentYellow),
                  onSuffixTap: () {
                    provider.searchController.clear();
                    provider.isSearching = false;
                    provider.loadRecentSearches();
                  },
                  onSubmitted: (value) {
                    provider.onSearch();
                  },
                )
                    : StatefulBuilder(
                  builder: (context, setState) {
                    return TextField(
                      controller: provider.searchController,
                      style: const TextStyle(color: AppColor.primaryText),
                      decoration: InputDecoration(
                        hintText: 'Search movies',
                        hintStyle: const TextStyle(color: AppColor.secondaryText),
                        prefixIcon: const Icon(Icons.search, color:  AppColor.accentYellow),
                        suffixIcon: provider.searchController.text.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.clear, color:  AppColor.accentYellow),
                          onPressed: () {
                            provider.searchController.clear();
                            provider.isSearching = false;
                            provider.loadRecentSearches();
                          },
                        )
                            : null,
                        filled: true,
                        fillColor: AppColor.secondaryText[900],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color:  AppColor.accentYellow, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (value) {
                        provider.onSearch();
                      },
                    );
                  },
                ),
              ),
              if (provider.recentSearches.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent',
                        style: TextStyle(
                          color: AppColor.secondaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: screenSize.height * 0.05,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.recentSearches.length,
                          itemBuilder: (context, index) {
                            final search = provider.recentSearches[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Chip(
                                label: GestureDetector(
                                  onTap: () {
                                    provider.onRecentSearchTap(search);
                                  },
                                    child: Text(search, style: const TextStyle(color: AppColor.primaryText))),
                                deleteIcon: const Icon(Icons.close, size: 18, color:  AppColor.accentYellow),
                                onDeleted: () {
                                  provider.removeRecent(index);
                                },
                                backgroundColor: AppColor.secondaryText[900],
                                labelStyle: const TextStyle(color: AppColor.primaryText),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  provider.isSearching ? "Search Result" : 'Popular Movies',
                  style: const TextStyle(
                    color:  AppColor.accentYellow,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          );
        }),
        const SizedBox(height: 10),
        Expanded(
          child: Consumer<MovieProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(
                    child: Platform.isIOS
                        ? const CupertinoActivityIndicator(color:  AppColor.accentYellow)
                        : const CircularProgressIndicator(color:  AppColor.accentYellow));
              } else if (provider.errorMessage != null) {
                return Center(child: Text(provider.errorMessage!, style: const TextStyle(color: AppColor.primaryText)));
              } else if (provider.movieList.isEmpty) {
                return const Center(child: Text("No movies found.", style: TextStyle(color: AppColor.primaryText)));
              } else {
                return Platform.isIOS
                    ? _buildIOSGridView(provider.movieList, provider.searchList, provider.isSearching)
                    : _buildAndroidGridView(provider.movieList, provider.searchList, provider.isSearching);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildIOSGridView(List<PopularMovies> movies, List<Results> searchResult, bool isSearching) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return isSearching ? _buildSearchMovieCard(searchResult[index]) : _buildMovieCard(movies[index]);
              },
              childCount: isSearching ? searchResult.length : movies.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAndroidGridView(List<PopularMovies> movies, List<Results> searchResult, bool isSearching) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: isSearching ? searchResult.length : movies.length,
      itemBuilder: (context, index) {
        return isSearching ? _buildSearchMovieCard(searchResult[index]) : _buildMovieCard(movies[index]);
      },
    );
  }

  Widget _buildMovieCard(PopularMovies movie) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.secondaryText[900],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: CachedNetworkImage(
                imageUrl: movie.primaryImage ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => Center(
                  child: Platform.isIOS
                      ? const CupertinoActivityIndicator(color:  AppColor.accentYellow)
                      : const CircularProgressIndicator(color:  AppColor.accentYellow),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.primaryTitle ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Platform.isIOS ? CupertinoIcons.star_fill : Icons.star,
                      color: AppColor.accentYellow,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      movie.averageRating != null ? '${movie.averageRating ?? '0'}/10' : '0/10',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.secondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Center(
          //   child: Padding(
          //     padding: const EdgeInsets.all(10),
          //     child: Platform.isIOS
          //         ? CupertinoButton(
          //       color: AppColor.accentYellow,
          //       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          //       child: const Text(
          //         'More Details',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //       onPressed: () {},
          //     )
          //         : ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         primary: AppColor.accentYellow,
          //         onPrimary: Colors.black,
          //         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //       ),
          //       onPressed: () {},
          //       child: const Text('More Details'),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildSearchMovieCard(Results movie) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.secondaryText[900],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: CachedNetworkImage(
                imageUrl: movie.primaryImage ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => Center(
                  child: Platform.isIOS
                      ? const CupertinoActivityIndicator(color:  AppColor.accentYellow)
                      : const CircularProgressIndicator(color:  AppColor.accentYellow),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.broken_image_rounded,
                  color: AppColor.secondaryText,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.primaryTitle ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Platform.isIOS ? CupertinoIcons.star_fill : Icons.star,
                      color:   AppColor.accentYellow,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${movie.averageRating ?? 'N/A'}/10',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.secondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}