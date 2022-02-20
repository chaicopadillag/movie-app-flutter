import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCard extends StatelessWidget {
  final int movieId;
  const CastingCard({Key? key, required this.movieId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            width: double.infinity,
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }
        final List<Cast> casts = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: casts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int i) => _CastCard(cast: casts[i]),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast cast;
  const _CastCard({
    Key? key,
    required this.cast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/images/loading.gif'),
                  image: NetworkImage(cast.profilePathUrl),
                  height: 140,
                  width: 100,
                  fit: BoxFit.cover)),
          const SizedBox(height: 5),
          Text(
            cast.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
