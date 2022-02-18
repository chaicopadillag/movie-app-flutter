import 'package:flutter/material.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Text(
              'Popular Movies',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          _MoviePoster(),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (_, int index) {
          return Container(
            width: 130,
            height: 190,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'detail'),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const FadeInImage(
                      placeholder: AssetImage('assets/images/loading.gif'),
                      image:
                          NetworkImage('http://placeimg.com/640/480/animals'),
                      width: 130,
                      height: 190,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Movie Step lormem saldlasdklakdla ladasdas',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
