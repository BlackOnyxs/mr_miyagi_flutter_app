import 'package:flutter/material.dart';

import 'package:mr_miyagi_app/core/models/address_model.dart';
import 'package:mr_miyagi_app/core/utils/routing_constant.dart';
import 'package:mr_miyagi_app/core/viewmodels/settings_view_model.dart';

import 'base_view.dart';


class SettingView extends StatelessWidget {
  const SettingView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return BaseView<SettingViewModel>(
      builder: ( context, model, child ) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SafeArea(
                child: Container(
                height: 50.0,
              ),
              ),
              Container(
                margin: EdgeInsets.symmetric( vertical: 30.0),
                padding: EdgeInsets.symmetric(vertical: 20.0),
                width: _screenSize.width * 0.95,
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
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'In order to make shipments we need to know your location. Please fill in the following fields.',
                        style: TextStyle(
                          fontSize: 20
                          )
                        ),
                    ),
                    SizedBox( height: 20.0 ),
                    _createNeighborhoodName( 'Neighborhood Name', 'Recidencial...', model),
                    SizedBox( height: 20.0 ),
                     _creaStreetName('Street Name','Souls street', model),
                    SizedBox( height: 20.0 ),
                    _createHouseNumber('House Number', '67', model),
                    SizedBox( height: 20.0 ),
                    _createGeneralDescription('General Desciption', 'In front of the tree ...', model),
                    SizedBox( height: 25.0 ),
                    _createButton( model, context ), 
                  ],
                ),
              ),
          SizedBox( height: 100.0 )
        ],
      ),
    ),
      ),
    );
  }

  Widget _createNeighborhoodName(String text, String hint, SettingViewModel model ){
    return Container(
      padding: EdgeInsets.only(top:25.0, left: 15.0, right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 30.0,
            child: Text(
              '$text',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black
              ),
            ),
          ),
          Container( 
            child: StreamBuilder(
              stream: model.neighborhoodStream,
              builder: ( BuildContext context, AsyncSnapshot snapshot){
                return TextField(
                  onChanged:model.neighborhoodChange,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    hintText: hint, 
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic
                    ),
                    errorText: snapshot.error
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _creaStreetName(String text, String hint, SettingViewModel model ){
    return Container(
      padding: EdgeInsets.only(top:25.0, left: 15.0, right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 30.0,
            child: Text(
              '$text',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black
              ),
            ),
          ),
          Container( 
            child: StreamBuilder(
              stream: model.streetStream,
              builder: ( BuildContext context, AsyncSnapshot snapshot){
                return TextField(
                  onChanged: model.streetChange,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    hintText: hint, 
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic
                    ),
                    errorText: snapshot.error
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _createHouseNumber(String text, String hint, SettingViewModel model ){
    return Container(
      padding: EdgeInsets.only(top:25.0, left: 15.0, right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 30.0,
            child: Text(
              '$text',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black
              ),
            ),
          ),
          Container( 
            child: StreamBuilder(
              stream: model.houseStream,
              builder: ( BuildContext context, AsyncSnapshot snapshot){
                return TextField(
                  onChanged: model.houseChange,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    hintText: hint, 
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic
                    ),
                    errorText: snapshot.error
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _createGeneralDescription(String text, String hint, SettingViewModel model ){
    return Container(
      padding: EdgeInsets.only(top:25.0, left: 15.0, right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 30.0,
            child: Text(
              '$text',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black
              ),
            ),
          ),
          Container( 
            child: StreamBuilder(
              stream: model.generalStream,
              builder: ( BuildContext context, AsyncSnapshot snapshot){
                return TextField(
                  onChanged:model.generalChange,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    hintText: hint, 
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic
                    ),
                    errorText: snapshot.error
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createButton( SettingViewModel model, BuildContext context){
    return StreamBuilder(
      stream: model.validateForm,
      builder: ( BuildContext context, AsyncSnapshot snapshot){
        return Padding(
          padding: EdgeInsets.only(right: 15.0, left: 15.0),
          child: FlatButton(
            child: Text(
               'Submit'
            ),
            onPressed: snapshot.hasData ? (){
              AddressModel currentAddress = model.createAddress(
                neighborHoodN     : model.neigborhood, 
                streetN           : model.street, 
                houseN            : model.house, 
                genaralDescription: model.general,
              );
               model.navigateTo(LOCATION_SETTINGS_VIEW_ROUTE, arg: currentAddress);
            } : null
          )
        );
      },
    );
    
  }
      
  
}