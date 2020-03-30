import 'package:flutter/material.dart';

import 'package:mr_miyagi_app/core/models/food_model.dart';
import 'package:mr_miyagi_app/core/models/order_model.dart';
import 'package:mr_miyagi_app/core/utils/error_constant.dart';
import 'package:mr_miyagi_app/core/utils/routing_constant.dart';
import 'package:mr_miyagi_app/core/viewmodels/cart_view_model.dart';
import 'package:mr_miyagi_app/ui/widgets/busy_button.dart';
import 'package:positioned_tap_detector/positioned_tap_detector.dart';

import 'base_view.dart';

class CartView extends StatefulWidget {
  CartView({Key key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool state;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BaseView<CartViewModel>(
      onModelReady: ( model ){
        state = model.getState();
      },
      builder: ( context, model, child ) {
        return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder( 
          stream: model.orderStream,
          builder: ( BuildContext context, AsyncSnapshot<OrderModel> snapshot){
            if ( snapshot.hasData ) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _createTitle( snapshot.data, size ),
                    _createList( snapshot.data, model, size ),
                    snapshot.data.subTotalPrice != INITIAL_PRICE?
                    _createDetails( model, snapshot.data, size ) :
                    Center(
                      child: Text(
                        "You haven't added anything yet",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    )
                  ],
                )
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(left:15.0, right: 15.0),
                child: Center(
                  child: Text(
                    "You haven't added anything yet",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                ) ,
              );
            }
          },
        )
        );
      }
    );
  }

  Widget _createTitle( OrderModel currentOrder, Size size){
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

  Widget _createList(OrderModel currentOrder, CartViewModel model, Size size){
    return Container(
      child: currentOrder.localFoods != null && currentOrder.localFoods.length >= 0?
          ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: currentOrder.localFoods.length,
          itemBuilder: ( context, index ) => _createItem(currentOrder.localFoods[index], model, size)
        ) :
        Container()
    );
    
  }

  Widget _createItem( FoodModel food, CartViewModel model, Size size ){
    return Container(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: InkWell(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
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
                                padding: EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: size.width * 0.40,
                                      child: _createFirstBloc(food.displayName, food.price, size),
                                    ),
                                    Container(
                                      width: size.width * 0.32,
                                      child: _createSecondBloc(food.cant, size),
                                    ),
                                    Container(
                                      //width: size.width * 0.40,
                                      child: _createPopUpMenu(food, model ),
                                    ),
                                  ],
                                )
                              ),
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
        ]
      ),
    );
  }
Widget _createFirstBloc(String name, String price, Size size){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: size.width * 0.40,
        child: Text(
          name,
          style: TextStyle(
            fontSize: 20
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
          ),
          textAlign: TextAlign.left,
        ),
      )
    ],
  );
}

Widget _createPopUpMenu( dynamic food, CartViewModel model ){
  return PositionedTapDetector(
    child: Icon(Icons.more_vert),
    onTap: ( position ){
      showMenu(
        context: context, 
        position: RelativeRect.fill.shift(position.global),
        items: [
          PopupMenuItem(
            child: GestureDetector(
              child:  Text(
              'Edit'
              ),
              onTap: () {
                model.goback();
                model.navigateTo( EDIT_FOOD_ALERT_VIEW_ROUTE, arg: food);
                /*await showDialog(
                  context: context,
                  builder: ( context ) {
                    return EditFoodAlertView( food: food );
                  }
                );*/
              },
            ),
          ),
          PopupMenuItem(
            child: GestureDetector(
              child:  Text(
              'Delete'
              ),
              onTap: (){
                model.deleteFood( food.id );
                model.goback();
                setState(() {
                  
                });
              },
            ),
          ),
        ],
        elevation: 8.0
      );
    },
  );
}

Widget _createSecondBloc(  int cant, Size size ){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      Container(
        width: size.width * 0.20,
        child:Text(
          'Cant',
          style: TextStyle(
            fontSize: 20,
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
            fontSize: 20
          ),
        ),
      )
    ],
  );
}





Widget _createDetails( CartViewModel model, OrderModel currentOrder, Size size ){
  return Container(
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.only(top:10.0, right: 15.0, left: 15.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createSimpleText( 'Sub Total: B/${currentOrder.subTotalPrice}'),
          _createTextImage(
            model.getPrimaryAddress() != null? 
            '${model.getPrimaryAddress().neighborhoodName} ' :
            'Please config your primary address', 'change',
            size),
          _createSimpleText( 'Cost of delivery: B/3.56'),
          SizedBox(height: 30.0),
          _createSimpleText( 'Total Cost: B/.${currentOrder.totalPrice}'),
          SizedBox(height: 30.0),
          _createButton(  model )
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
    textAlign:
    TextAlign.start
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

  Widget _createButton(  CartViewModel model ){
    return  BusyButton(
      title: 'Submit', 
      busy: model.busy,
      enabled: true,
      onPressed: ()  {
        print('CartView : onTap()');
         model.sentOrder();
      }
    );
  } 

}