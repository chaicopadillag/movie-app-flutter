import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/search/search_delegate.dart';
import 'package:movie_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Movies in cinema',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () =>
                showSearch(context: context, delegate: MoviesSearchDelegate()),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        CardSwiper(movies: moviesProvider.onDisplayMovies),
        MovieSlider(
            movies: moviesProvider.popularMovies,
            onNextPage: () => moviesProvider.getPopularMovies()),
      ])),
    );
  }
}
