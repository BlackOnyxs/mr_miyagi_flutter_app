import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mr_miyagi_app/core/models/daily_lunch_model.dart';
import 'package:mr_miyagi_app/core/utils/routing_constant.dart';
import 'package:mr_miyagi_app/core/viewmodels/daily_lunch_view_model.dart';

import 'base_view.dart';

class DailyLunchView extends StatelessWidget {
  DailyLunchView({Key key}) : super(key: key);
   
  final titleStyle = TextStyle(fontSize: 25, color: Colors.white,  fontWeight: FontWeight.bold);
  final descriptionStyle = TextStyle(fontSize: 15, color: Colors.white, fontStyle: FontStyle.normal);
  

  @override
  Widget build(BuildContext context) {
    return BaseView<DailyLunchViewModel>(
      onModelReady: ( model )=> model.listenDailyLunch(),
      builder: ( context, model, child) =>
      Scaffold(
        appBar: AppBar(
          title: Text( 'Daily Lunch'),
        ),
        body:Center(
          child:  _createList( model ),
        ),
      )
    );
  }

  Widget _createList( DailyLunchViewModel model ) {
    List<DailyLunchModel> lunches = new List();
    return StreamBuilder(
      stream: model.dailyLunchStream,
      builder: ( BuildContext context, AsyncSnapshot<List<DailyLunchModel>> snapshot){
        if (snapshot.hasData) {
          lunches = snapshot.data;
        }
        if (lunches != null && lunches.length>0) {
          return ListView.builder(
            itemCount:lunches.length,
            itemBuilder: ( context, i) => _createItem(context, lunches[i], model),
          ); 
        }else{
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
            ),
          );
        }
      },
    ); 
  
  }

  Widget _createItem( BuildContext context, DailyLunchModel dailyLunch, DailyLunchViewModel model ){
  final size = MediaQuery.of(context).size;
  final imageBackground = Container(
    height: size.height * 0.3,
    width: double.infinity,
    child: ( dailyLunch.food.photoUrl == null ) ?
      Image(image: AssetImage('assets/no-image.jpg'))
      : FadeInImage(
        image: NetworkImage(dailyLunch.food.photoUrl),
        placeholder: AssetImage("assets/loading.gif"),
        height: 200.0,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
  );
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
          child: Card(
            elevation: 5.0,
            child: Stack(
            children: <Widget>[
              imageBackground,
              Container(
                padding: EdgeInsets.only(
                  top: 100.0,
                  left: 5.0
              ),
              child:BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: Column(
                  children: <Widget>[
                    Text('${dailyLunch.food.displayName}', style: titleStyle),

                  ],
              )
              )
            )
          ],
          ),
        ),
      ),
      onTap: (){
        model.navigateTo(FOOD_DETAIL_VIEW_ROUTE, dailyLunch);
      }
    );
  }
  

}
