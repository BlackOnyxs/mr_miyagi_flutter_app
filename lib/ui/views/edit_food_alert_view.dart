import 'package:flutter/material.dart';
import 'package:mr_miyagi_app/core/models/daily_lunch_model.dart';
import 'package:mr_miyagi_app/core/models/ingredient_model.dart';
import 'package:mr_miyagi_app/core/viewmodels/cart_view_model.dart';


import 'base_view.dart';

class EditFoodAlertView extends StatefulWidget {
  final dynamic food;
  const EditFoodAlertView({Key key, this.food}) : super(key: key);

  @override
  _EditFoodAlertViewState createState() => _EditFoodAlertViewState();
}

class _EditFoodAlertViewState extends State<EditFoodAlertView> {
  @override
  Widget build(BuildContext context) {
     var _screenSize = MediaQuery.of(context).size;
    return  BaseView<CartViewModel>(
      builder: ( context, model, child )=> Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar:  AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:Container(
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
                  height: double.infinity,
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
                        _createTitle( widget.food.displayName ),
                        (widget.food is DailyLunchModel)?
                        _createList(  widget.food, model) : Container(),
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

  Widget _createList(dynamic dailyLunch, CartViewModel model ){
    if (dailyLunch != null && dailyLunch.food.ingredients.length > 0) {
      return ListView.builder(
        itemCount: dailyLunch.food.ingredients.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: ( context, index ) => _createItem(dailyLunch.food.ingredients[index], model),
      );
    }else{
      return Center(
        child: CircularProgressIndicator(), //TODO: return Container
      );
    }
  }

  Widget _createItem(IngredientModel ingredient, CartViewModel model ){
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

  Widget _createCant( Size screenSize, CartViewModel model ){
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

 Widget _createButton( CartViewModel model, BuildContext context  ){
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
                model.updateOrder(widget.food.id, cant );        
                model.goback();
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