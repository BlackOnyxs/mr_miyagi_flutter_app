
import 'package:flutter/material.dart';
import 'package:mr_miyagi_app/core/models/food_model.dart';
import 'package:mr_miyagi_app/core/models/order_model.dart';
import 'package:mr_miyagi_app/core/utils/state_constant.dart';
import 'package:mr_miyagi_app/core/viewmodels/order_view_model.dart';

import 'base_view.dart';

class OrderView extends StatelessWidget {
  final String id;
  OrderView({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BaseView<OrderViewModel>(
      onModelReady: ( model ) async{
         //String id = "282";//This is for test 
        if ( id != null) {
          await model.listenOrder(id);
        }
      },
      builder: ( BuildContext context, OrderViewModel model, Widget child ) => 
        Scaffold(
          appBar: AppBar(),
          body:  SingleChildScrollView(
            child: StreamBuilder(
              stream: model.orderStream,
              builder: ( BuildContext context,  AsyncSnapshot<OrderModel> snapshot ){
                if ( snapshot.hasData ) {
                  return _createChild( context, snapshot.data, size, model );
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          )
        ),
    );
  }

  Widget _createChild( BuildContext context, OrderModel currentOrder, Size size, OrderViewModel model  ){
    return Column(
      children: <Widget>[
        _createTitle( size, currentOrder ),
        _createList( currentOrder, size ),
         _createDetails( context, model, currentOrder, size ), 
      ],
    );
  }

  Widget _createTitle( Size size, OrderModel currentOrder ){
    return Container(
      width: size.width *0.9,
      margin: EdgeInsets.only(top:35.0),
      padding: EdgeInsets.only(left: 110.0, right: 90.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child:Text(
          'Order: ${currentOrder.id}',
          style: TextStyle(
            fontSize: 25.0,
            fontFamily: 'Karla'
          ),
        ),
    );
  }

  Widget _createList(OrderModel currentOrder, Size size){
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: currentOrder.localFoods != null ?ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: currentOrder.localFoods.length,
        itemBuilder: ( context, index ) => _createItem(currentOrder.localFoods[index], size)
      ) : 
    Center(
      child: CircularProgressIndicator(),
    )
    );
  }

  Widget _createItem( FoodModel food, Size size ){
    return Container(
      margin: EdgeInsets.symmetric( vertical: 15.0),
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: size.width * 0.90,
      height: size.height * 0.12,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: size.width * 0.40,
                  child: _createFirstBloc(food.displayName, food.price, size),
                ),
                Container(
                  width: size.width * 0.40,
                  child: _createSecondBloc(food.cant.toString(), size),
                )
              ],
            )
          ),
        ]
      )
    );         
  }
Widget _createFirstBloc(String name, String price, Size size){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: size.width * 0.55,
        child: Text(
          name,
          style: TextStyle(
            fontSize: 20, 
            // color: (food.state) ? Colors.green : Colors.red 
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
        ),
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.bottomLeft,
        width: size.width * 0.20,
        child: Text(
          'B/$price',
          style: 
          TextStyle(
            fontSize: 20, 
            // color: (food.state) ? Colors.green : Colors.red 
          ),
          textAlign: TextAlign.left,
        ),
      )
    ],
  );
}

Widget _createSecondBloc(  String cant,   Size size ){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      Container(
        width: size.width * 0.20,
        child:Text(
          'Cant',
          style: TextStyle(
            fontSize: 20,
            // color: (food.state) ? Colors.green : Colors.red 
          ),
        ),
      ),
      SizedBox(height: 10.0),
      Container(
        width: size.width * 0.20,
        child: Text(
          '$cant',
          style: 
          TextStyle(
            fontSize: 20, 
            // color: (food.state) ? Colors.green : Colors.red 
          ),
        ),
      )
    ],
  );
}

  Widget _createDetails( BuildContext context, OrderViewModel model, OrderModel currentOrder, Size size ){
  return Container(
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.only(top:10.0, right: 15.0, left: 15.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createSimpleText( 'Total: B/${currentOrder.totalPrice}'),
          _createTextImage(
            /* currentOrder.userAddress.neighborhoodName == null ? '' : 'example' */
            'Example', 'map',
            size),
          SizedBox(height: 30.0),
          _createStateOrder(currentOrder.state, size),
          SizedBox(height: 30.0),
          /* (currentOrder.state == onRoute) ?
          _createButton( context, model ) : */
          Container(), 
        ],
      ),
    ),
  );
}

Widget _createSimpleText( String text ){
  return Text(
    text,
    style: TextStyle(
    fontSize: 18
    ),
    textAlign: TextAlign.start
  );
}
Widget _createTextImage( String text, String iconName, Size size){
  return  Row(
    children: <Widget>[
      Container(
        width: size.width * 0.65,
        child: Text(
          'Address: $text',
          style: TextStyle(
          fontSize: 18,
          ),
          textAlign:
          TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        width: size.width * 0.2,
        child: Image(
          image: AssetImage('assets/$iconName.png'),
        ),
      ),
    ],
    
  );
}
Widget _createStateOrder( int orderState, Size size ){
  return Column(
    children: <Widget>[
      _createStateItem(orderState, onQueue ,'On Queue' , size),
      _createStateItem(orderState, onCooking ,'Cooking', size),
      _createStateItem(orderState, onRoute,'On Route'  , size),
    ],
  );
}
Widget _createStateItem( int orderState, int stateCode,String stateName, Size size ){
  return Container(
    width: size.width * 0.4,
    height: size.height * 0.08,
    padding: EdgeInsets.only(left: 10.0, right: 10.0),
    child: Row(
      children: <Widget>[
        (orderState < stateCode)?
        CircularProgressIndicator() : 
          Icon(Icons.check, color: Colors.green),
        Text(stateName)
      ],
    ),
  );
}

/* Widget _createButton( BuildContext context, OrderViewModel model  ){
  return Center(
    child: RaisedButton(
      color: Colors.lightBlueAccent,
      child: Text('Track your Order'),
      onPressed: () => model.navigateTo(HOME_VIEW_ROUTE /* MapView */),
    )
  );
} */

}