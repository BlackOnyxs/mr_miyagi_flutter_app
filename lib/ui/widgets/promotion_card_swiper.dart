
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mr_miyagi_app/core/models/promotion_model.dart';
import 'package:mr_miyagi_app/core/viewmodels/home_view_model.dart';

class PromotionCardSwiper extends StatelessWidget {
  final List<PromotionModel> promotions;
  final HomeViewModel model;
  const PromotionCardSwiper({@required this.promotions, this.model});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top:20.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width *0.7,
        itemHeight: _screenSize.height *0.4,
        itemBuilder: (BuildContext conetext, int index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: GestureDetector(
              // onTap: ()=> model.navigateTo(, arg: promotions[index].restId),
              child: FadeInImage(
                image: NetworkImage(promotions[index].photoUrl),
                placeholder: AssetImage('assets/no-image.png'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        itemCount: promotions.length,
      ),
    );
  }
}