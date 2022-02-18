import 'package:flutter/material.dart';
import 'package:movie_app/theme/app_theme.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String index =
        ModalRoute.of(context)!.settings.arguments.toString() ?? 'no index';
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(delegate: SliverChildListDelegate([_PosterAbout()]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.primaryColor,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(2),
        title: Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            color: Colors.black12,
            child: const Text('Movie Detail')),
        background: const FadeInImage(
            placeholder: AssetImage('assets/images/loading.gif'),
            image: NetworkImage('http://placeimg.com/640/480/nature'),
            fit: BoxFit.cover),
      ),
    );
  }
}

class _PosterAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/images/loading.gif'),
              image: NetworkImage('http://placeimg.com/640/480/nature'),
              fit: BoxFit.cover,
              width: 100,
              height: 150,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Movie Title',
                style: textTheme.headline6,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text('Movie Original Title',
                  style: textTheme.subtitle1, overflow: TextOverflow.ellipsis),
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                ],
              ),
              Text('Movie vote average', style: textTheme.caption),
            ],
          )
        ],
      ),
    );
  }
}
