import 'package:flutter/material.dart';
import 'package:mr_miyagi_app/core/models/daily_lunch_model.dart';
import 'package:mr_miyagi_app/core/models/ingredient_model.dart';
import 'package:mr_miyagi_app/core/viewmodels/food_detail_alert_model.dart';
import 'package:mr_miyagi_app/ui/views/base_view.dart';

class FoodDeatilViewAlert  extends StatefulWidget {
  final DailyLunchModel dailyLunch;
  const FoodDeatilViewAlert({Key key, this.dailyLunch}) : super(key: key);

  @override
  _FoodDeatilViewAlertState createState() => _FoodDeatilViewAlertState();
}

class _FoodDeatilViewAlertState extends State<FoodDeatilViewAlert> {
  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;

    return  BaseView<FoodDetailAlertModel>(
      builder: ( context, model, child )=> Scaffold(
        backgroundColor: Colors.transparent,
        appBar:  AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                SafeArea(
                  child: Container(
                    height: _screenSize.height *0.20,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric( vertical: 10.0),
                  padding: EdgeInsets.symmetric( vertical: 20.0),
                  height: _screenSize.height * 0.90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular( 25.0 ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3.0,
                        offset: Offset(0.0, 5.0),
                        spreadRadius: 3.0
                      )
                    ]
                  ),
                  child:
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Column(
                      children: <Widget>[
                        _createTitle( widget.dailyLunch.displayName ),
                        _createImage( widget.dailyLunch.food.photoUrl, _screenSize ),
                        _createList(  widget.dailyLunch, model),
                        _createCant( _screenSize, model ),
                        _createButton( model, context )
                      ],
                      ),
                    ),
                ),
              ]
            )
          ),
        )
      )
    );
  }

  Widget _createImage( String photoUrl, Size size ){
    final image = Container(
    height: size.height * 0.3,
    width: double.infinity,
    child: ( widget.dailyLunch.food.photoUrl == null ) ?
      Image(image: AssetImage('assets/no-image.jpg'))
      : FadeInImage(
        image: NetworkImage(widget.dailyLunch.food.photoUrl),
        placeholder: AssetImage("assets/loading.gif"),
        height: 200.0,
        width: double.infinity,
        fit: BoxFit.cover,
      )
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
        child: Card(
          elevation: 5.0,
          child: image
        ),
    );
  }

  Widget _createTitle( String name ){
    return Center(
      child: Text(
        name,
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _createList(DailyLunchModel dailyLunch, FoodDetailAlertModel model ){
    if (dailyLunch != null && dailyLunch.food.ingredients.length > 0) {
      return ListView.builder(
        itemCount: dailyLunch.food.ingredients.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: ( context, index ) => _createItem(dailyLunch.food.ingredients[index], model),
      );
    }else{
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _createItem(IngredientModel ingredient, FoodDetailAlertModel model ){
    return Card(
      elevation: 5,
      child: CheckboxListTile(
        value: ( ingredient.status == null)? ingredient.status = false : ingredient.status, 
        onChanged: (value){
          setState(() {
            ingredient.status = value;
          });
        },
        title: Text(ingredient.name),
        subtitle: Text('B/.${ingredient.price}'),
        activeColor: Colors.green,
      ),
    );
  }

  Widget _createCant( Size screenSize, FoodDetailAlertModel model ){
    return Container(
      height: 45.0,
      child: Row(
        children: <Widget>[
          Container(
            width: 75.0,
            child: Text(
              'Cant',
              style: TextStyle(
                fontSize: 25.0
              ),
            ),
          ),
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
    );
  }

 Widget _createButton( FoodDetailAlertModel model, BuildContext context  ){
   return Container(
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
                widget.dailyLunch.food.cant = cant;
                model.addFoodToOrder(widget.dailyLunch);        
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
       
    ) 
     )
   );
 }
}
