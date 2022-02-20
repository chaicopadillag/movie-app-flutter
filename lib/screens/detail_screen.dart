import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/theme/app_theme.dart';
import 'package:movie_app/widgets/casting_cards.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
              backgroundImage: movie.getPosterUrl, title: movie.title),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterAbout(
              title: movie.title,
              backgroundImage: movie.getPosterUrl,
              titleOriginal: movie.originalTitle,
              voteAverage: movie.voteAverage.toString(),
              heroId: movie.heroId!,
            ),
            _OverView(description: movie.overview),
            _OverView(description: movie.overview),
            _OverView(description: movie.overview),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                'Reparto',
                style: TextStyle(fontSize: 20),
              ),
            ),
            CastingCard(movieId: movie.id),
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar(
      {Key? key, required this.title, required this.backgroundImage})
      : super(key: key);
  final String title;
  final String backgroundImage;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.primaryColor,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            color: Colors.black45,
            child: Text(title)),
        background: FadeInImage(
            placeholder: const AssetImage('assets/images/loading.gif'),
            image: NetworkImage(backgroundImage),
            fit: BoxFit.cover),
      ),
    );
  }
}

class _PosterAbout extends StatelessWidget {
  final String heroId;
  final String title;
  final String titleOriginal;
  final String backgroundImage;
  final String voteAverage;

  const _PosterAbout(
      {Key? key,
      required this.title,
      required this.backgroundImage,
      required this.titleOriginal,
      required this.voteAverage,
      required this.heroId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Hero(
            tag: heroId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/loading.gif'),
                image: NetworkImage(backgroundImage),
                fit: BoxFit.cover,
                width: 100,
                height: 150,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenSize.width - 160),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  titleOriginal,
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                  ],
                ),
                Text(voteAverage, style: textTheme.caption),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final String description;
  const _OverView({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        description,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
