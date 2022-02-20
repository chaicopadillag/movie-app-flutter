import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class MoviesSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyResult();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    moviesProvider.searchMoviesDebounced(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionsStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyResult();

        final movies = snapshot.data!;

        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index) => _MovieItem(movie: movies[index]));
      },
    );
  }

  Widget _emptyResult() {
    return const SizedBox(
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: AppTheme.primaryColor,
          size: 100,
        ),
      ),
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.heroId = '${movie.id}-search';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          image: NetworkImage(movie.getPosterUrl),
          placeholder: const AssetImage('assets/images/loading.gif'),
          width: 50.0,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }
}
