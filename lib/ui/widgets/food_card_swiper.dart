
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mr_miyagi_app/core/models/food_model.dart';
import 'package:mr_miyagi_app/core/viewmodels/food_card_model_view.dart';
import 'package:mr_miyagi_app/ui/views/base_view.dart';

class FoodCardSwiper extends StatelessWidget {
  final List<FoodModel> foods;
  const FoodCardSwiper({@required this.foods});

  @override
  Widget build(BuildContext context) {
    return BaseView<FoodCardModelView>(
     builder: ( context, model, child){
       final _screenSize = MediaQuery.of(context).size;
       return Scaffold(
         resizeToAvoidBottomInset: false,
         backgroundColor: Colors.transparent,
         appBar: AppBar(
           backgroundColor: Colors.transparent,
         ),
          body: Container(
            // padding: EdgeInsets.only(top:10.0),
            child: Swiper(
              layout: SwiperLayout.STACK,
              itemWidth: _screenSize.width *0.9,
              itemHeight: double.infinity,
              itemBuilder: (BuildContext context, int index){
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Column(
                    children: <Widget>[
                      _createImage(foods[index].photoUrl, _screenSize ),
                      _createTitle(foods[index], _screenSize, model )
                    ],
                  )
                );
              },
              itemCount: foods.length,
            ),
          )
       );
     }, 
    ); 
  }
  Widget _createImage( String photoUrl, Size size ){
    return Container(
      height: size.height * 0.3,
      width: double.infinity,
      child: FadeInImage(
        image: NetworkImage(photoUrl),
        placeholder: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
      ),
    );
  }
  Widget _createTitle( FoodModel food, Size size, FoodCardModelView model ){
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: Text(
              food.displayName,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.justify,
              
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
            child: Text(
              food.description,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right:15.0, left: 15.0, top:30),
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    'Cant',
                    style: TextStyle(
                      fontSize: 18.0
                    ),
                  ),
                ),
                SizedBox(width: 10.0,),
                Container(
                  width: 50.0,
                  height: 40.0,
                  child: StreamBuilder(
                    stream: model.cantStream,
                    builder: ( BuildContext context, AsyncSnapshot snapshot ){
                      return TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          hintText: '1',
                          errorText: snapshot.error
                        ),
                        onChanged: model.changeCant,
                      );
                    },
                  )
                ),
              ],
            ),
          ),
          Container(
             padding: EdgeInsets.only(top:15.0),
             child: ClipRRect(
               borderRadius: BorderRadius.circular(20.0),
               child: StreamBuilder(
                 stream : model.cantStream,
                 builder: ( BuildContext context, AsyncSnapshot snapshot ){
                   return RaisedButton(
                      onPressed: (snapshot.hasData) ?() {
                        var cant;
                        //TODO: validated that
                        if (model.cant.isNotEmpty) {
                          cant = int.parse(model.cant);
                        }else{
                          cant = 1;
                        }
                        food.cant = cant;
                        model.addFood(food);        
                        model.hideCart(context);
                      } : null,
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 25.0
                        ),
                      ),
                      elevation: 1.0,
                      color: Colors.indigoAccent,
                      textColor: Colors.white,
                      );
                 }

                ),
            
            )
          )
        ],
      )
    );
  }
  
  
}