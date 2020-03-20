/* import 'package:flutter/material.dart';
import 'package:mr_miyagi_app/core/models/food_model.dart';

class AddFoodAlert extends StatefulWidget {
  final FoodModel food;
  final RestaurantDeatilViewModel model;
  const AddFoodAlert({Key key, this.food, this.model}) : super(key: key);

  @override
  _AddFoodAlertState createState() => _AddFoodAlertState();
}


class _AddFoodAlertState extends State<AddFoodAlert> {

  @override
  Widget build(BuildContext context) {
    
    
    var _screenSize = MediaQuery.of(context).size;

    return  Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
      child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: _screenSize.height *0.65,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric( vertical: 10.0),
            padding: EdgeInsets.symmetric( vertical: 20.0),
            height: _screenSize.height * 0.50,
            width: _screenSize.width * 0.98,
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
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
              children: <Widget>[
                _createTitle(),
                _createItem( widget.food.name, widget.food.price ),
                _createCant( _screenSize, widget.model ),
                _createButton( widget.model, context )
              ],
            ),
             ),
            
          ),
        ],
      ),
    )
    ),
    );
   
  }

  Widget _createTitle(  ){
    return Container(
      height: 45.0,
      width: double.infinity,
      child: Text(
        'Add Food',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _createItem( String name, String price){
    return Container(
      height: 35.0,
      width: double.infinity,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //TODO: add BoxDecoration
          Container(
            width: 180.0,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 25.0,
                fontStyle: FontStyle.italic
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            width: 140.0,
            child: Text(
              'B/$price',
              style: TextStyle(
                fontSize: 20
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget _createCant( Size screenSize, RestaurantDeatilViewModel model ){
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
 
 Widget _createButton( RestaurantDeatilViewModel model, BuildContext context  ){
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
                widget.food.cant = cant;
                model.addFoodToOrder(widget.food);        
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
/*  @override
  void dispose() {
    super.dispose();
    widget.model.dispose();
  } */
}
 */