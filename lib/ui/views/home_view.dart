import 'package:flutter/material.dart';

import 'package:mr_miyagi_app/core/models/menu_section_base.dart';
import 'package:mr_miyagi_app/core/utils/routing_constant.dart';
import 'package:mr_miyagi_app/core/viewmodels/home_view_model.dart';
import 'package:mr_miyagi_app/ui/widgets/promotion_card_swiper.dart';

import 'base_view.dart';


class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final _screenSize = MediaQuery.of(context).size;
    return BaseView<HomeViewModel>(
      onModelReady: ( model){
         model.fetchPromotions();
         model.fetchServiceSections();
        // model.createMenuSection();
         //model.createDailyLunch();
      },
      onModelDestroy: ( model ) => model.dispose(),
      builder:  ( context, model, child ) => Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            GestureDetector(
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/cart.png'),
                radius: 25.0,
              ),
              ),
              onTap: () => model.navigateTo(CART_VIEW_ROUTE),
            ),
            GestureDetector(
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/default-user-img.png'),
                radius: 25.0,
              ),
              ),
              onTap: () => model.navigateTo(CART_VIEW_ROUTE),
            ),
          ],
        ),
        body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _swiperCard( context, model),
            _createList( context, model, _screenSize)
          ],
          ),
        ),
      )
    );
  }

  Widget _swiperCard( BuildContext context, HomeViewModel model ){
    return model.promotions != null ?
    PromotionCardSwiper(
      model: model,
      promotions: model.promotions
    ) : Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
      ),
    );
  }
  Widget _createList( BuildContext context, HomeViewModel model, Size size) {
    return  Container(
      height: size.height * 0.50,
      padding:EdgeInsets.only(top:10.0),
      child: model.sections != null ?
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: model.sections.length,
          itemBuilder: ( context, i ) => _cretateItem(context, model.sections[i], model ),
      
        ) :Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          ),
        )
    );
    
  }

  Widget _cretateItem( BuildContext context, MenuSectionBase currentSection, HomeViewModel model ){
    final size = MediaQuery.of(context).size;
    final image = Container (
      margin: EdgeInsets.only(left: 10.0, top: 22.0),
      child:Image(
        image: AssetImage(
        'assets/${currentSection.iconName}.png',
      ),
      fit: BoxFit.cover,
      height: 75.0,
      width: 75.0,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow:
       <BoxShadow>[
        BoxShadow(
        color: Colors.black26,
        blurRadius: 3.0,
        offset: Offset( 0.0, 0.5),
        spreadRadius: 3.0
        )
       ]
    ),
  
  );
                  
    return Container(
      child: Stack(
        children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 50.0, right: 10.0),
              child: InkWell(
              onTap: (){
                model.navigateTo(currentSection.iconName);
              },
              child: Row(
                children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric( vertical: 15.0),
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      width: size.width * 0.80,
                      height: size.width * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 3.0,
                            offset: Offset( 0.0, 5.0),
                            spreadRadius: 3.0
                          )
                           ]
                         ),
                         child:Row( 
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             Padding(
                               padding: EdgeInsets.only(left: 50.0),
                              child: Text(
                                  currentSection.displayName,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigoAccent
                                  ),
                              ),
                             ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                color: Colors.indigoAccent,
                                onPressed: (){}
                              )
                           ]
                         )
                    ),
                    
                  ],
                ),
              ),
                ]
              )
              )
            ),
          image
        ]

      ),
    );
  }
}