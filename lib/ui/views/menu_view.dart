import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mr_miyagi_app/core/models/menu_section_model.dart';
import 'package:mr_miyagi_app/core/utils/routing_constant.dart';
import 'package:mr_miyagi_app/core/viewmodels/menu_view_model.dart';

import 'base_view.dart';

class MenuView extends StatelessWidget {
  MenuView({Key key}) : super(key: key);
   
  final titleStyle = TextStyle(fontSize: 25, color: Colors.white,  fontWeight: FontWeight.bold);
  final descriptionStyle = TextStyle(fontSize: 15, color: Colors.white, fontStyle: FontStyle.normal);
  

  @override
  Widget build(BuildContext context) {
    return BaseView<MenuViewModel>(
      onModelReady: ( model )=> model.getMenuSections(),
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

  Widget _createList( MenuViewModel model ) {
    List<MenuSection> sections = new List();
    return StreamBuilder(
      stream: model.sectionStream,
      builder: ( BuildContext context, AsyncSnapshot<List<MenuSection>> snapshot){
        if (snapshot.hasData) {
          sections = snapshot.data;
        }
        if (sections != null && sections.length>0) {
          return ListView.builder(
            itemCount:sections.length,
            itemBuilder: ( context, i) => _createItem(context, sections[i], model),
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

  Widget _createItem( BuildContext context, MenuSection section, MenuViewModel model ){
  final size = MediaQuery.of(context).size;
  final imageBackground = Container(
    height: size.height * 0.3,
    width: double.infinity,
    child: ( section.photoUrl == null ) ?
      Image(image: AssetImage('assets/no-image.jpg'))
      : FadeInImage(
        image: NetworkImage(section.photoUrl),
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
                    Text('${section.displayName}', style: titleStyle),

                  ],
              )
              )
            )
          ],
          ),
        ),
      ),
      onTap: (){
        model.navigateTo(MENU_SECTION_DETAIL_ROUTE, arg:section.foods);
        /* showDialog(
          context: context,
          barrierDismissible: false,
          builder: ( context ){
            return FoodCardSwiper(foods: section.foods);
          }
        ); */
      }
    );
  }
  

}
