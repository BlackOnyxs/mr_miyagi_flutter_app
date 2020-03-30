import 'package:flutter/material.dart';

import 'package:mr_miyagi_app/core/models/address_model.dart';
import 'package:mr_miyagi_app/core/utils/routing_constant.dart';
import 'package:mr_miyagi_app/core/viewmodels/location_setting_view_model.dart';

import 'base_view.dart';

class LocationSettingView extends StatelessWidget {
  final AddressModel currentAddress;
  LocationSettingView({Key key, this.currentAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BaseView<LocationSettingViewModel>(
      builder: ( context, model, child ) {
        var _screenSize = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(
            
          ),
          body: Container(
            padding: EdgeInsets.only(top:50.0),
            child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                 Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Column(
                  children: <Widget>[
                     _createTitle(),
                     _createBody(),
                     _createCurrentLocationButton( context, model, currentAddress, _screenSize),
                     SizedBox(height: 10.0),
                     _createFromMapButton( model, _screenSize),
                     SizedBox(height: 10.0),
                     _createSkipButton()
                  ],
                ),
                 ),
              ],
            ),
            )
          ),
        );
      }
    );
  }
   Widget _createTitle(  ){
    return Container(
      height: 45.0,
      width: double.infinity,
      child: Text(
        'Select a Method',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  Widget _createBody(){
    return Container(
      height: 110.0,
      width: double.infinity,
      child: Text(
        'If you are at the address described above press "current location" otherwise press "select on the map". Note: if you do not know how to manipulate on the map press "skip".',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
 Widget _createCurrentLocationButton( BuildContext context, LocationSettingViewModel model, AddressModel currentAddress, Size screenSize ){
   return GestureDetector(
     child: Container(
     width: double.infinity,
     height: screenSize.height * 0.10,
     decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular( 5.0 ),
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
       padding: EdgeInsets.only(right: 15.0, left: 15.0),
       child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: <Widget>[
          Text(
           'Current Location',
           style: TextStyle(
             fontSize: 20.0,
             fontWeight: FontWeight.bold
           ),
         ),
         Image.asset('assets/marker_red.png')
       ],
        ),
      )
      ),
      onTap: (){
        model.getCurrentPosition(currentAddress);
      },
   );
 }
 Widget _createFromMapButton( LocationSettingViewModel model, Size screenSize ){
   return GestureDetector(
    child :Container(
     width: double.infinity,
     height: screenSize.height * 0.10,
     decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular( 5.0 ),
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
       padding: EdgeInsets.only(right: 15.0, left: 15.0),
       child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: <Widget>[
          Text(
           'Select From Map',
           style: TextStyle(
             fontSize: 20.0,
             fontWeight: FontWeight.bold
           ),
         ),
         Image.asset('assets/map.png')
       ],
     ),
   )
   ),
    onTap: (){
        model.navigateTo(MAP_SETTINGS_VIEW_ROUTE, currentAddress: currentAddress );
    }
   );
 }
 Widget _createSkipButton(){
   return FlatButton(
     padding: EdgeInsets.only(left: 250.0),
    onPressed: (){}, 
    child: Text(
      'Skip',
      style: TextStyle(
        color: Colors.redAccent,
        decoration: TextDecoration.underline,
        fontSize: 18.0
      ),
    )
  );
 }
}