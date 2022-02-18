import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: sizeScreen.height * 0.5,
      child: Swiper(
        itemCount: 10,
        layout: SwiperLayout.STACK,
        itemWidth: sizeScreen.width * 0.6,
        itemHeight: sizeScreen.height * 0.4,
        itemBuilder: (__, int index) {
          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detail', arguments: index),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const FadeInImage(
                  placeholder: AssetImage('assets/images/loading.gif'),
                  image: NetworkImage('http://placeimg.com/300/400/nature'),
                  fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
