import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:movie_app/models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: sizeScreen.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: sizeScreen.height * 0.5,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: sizeScreen.width * 0.6,
        itemHeight: sizeScreen.height * 0.4,
        itemBuilder: (__, int index) {
          final movie = movies[index];

          movie.heroId = '${movie.id}-poster';

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detail', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    placeholder: const AssetImage('assets/images/loading.gif'),
                    image: NetworkImage(movie.getPosterUrl),
                    fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }
}
