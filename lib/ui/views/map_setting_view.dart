import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mr_miyagi_app/core/models/address_model.dart';
import 'package:mr_miyagi_app/core/viewmodels/map_setting_view_model.dart';
import 'package:mr_miyagi_app/ui/views/base_view.dart';

class MapSettingView extends StatefulWidget {
  final AddressModel currentAddress;
  MapSettingView({Key key, this.currentAddress}) : super(key: key);

  @override
  _MapSettingViewState createState() => _MapSettingViewState();
}

class _MapSettingViewState extends State<MapSettingView> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = new Set();

  var _lastPosition;

  void _onAddMarker( BuildContext context, MapSettingViewModel model, LatLng currentPosition ){
    
        _markers.add(Marker(
        markerId: MarkerId('last'),
        infoWindow: InfoWindow(
          title: 'Your current location.',
          snippet: 'This is your current location'
        ),
        position: currentPosition,
        icon: BitmapDescriptor.defaultMarker,
        draggable: true,
        onDragEnd: ( value ){
          _lastPosition = value;
          print(value);
        },
        onTap: ()=> _showAutoDetectionAlert(context, model, currentPosition, widget.currentAddress)
      )
      );
  }

  void _onCameraMove(CameraPosition position){
    _lastPosition = position.target;
  }
  
  void _onMapCreated( GoogleMapController controller ){
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MapSettingViewModel>(
      onModelReady: ( model ){
        //model.getLocation();
      },
       builder: ( context, model, child ) => Scaffold(
         body: Stack(
           children: <Widget>[
            _thing( context, model ),
            Padding(
              padding: EdgeInsets.only(top: 600.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "minus",
                      child: Image(
                        image: AssetImage('assets/minus.png'),
                      ),
                      backgroundColor: Colors.transparent,
                      onPressed: (){
                       //TODO: add Zoom in/ out
                       
                      }
                    ),
                    FloatingActionButton(
                      heroTag: "plus",
                      child: Image(
                        image: AssetImage('assets/plus.png'),
                      ),
                      backgroundColor: Colors.transparent,
                      onPressed: (){}
                    ),
                  ],
                )
              ),
            ),
          ],
         ), 
       )
    );
  }

  Widget _thing ( BuildContext context, MapSettingViewModel model  ){
    LatLng _currentPosition;
    return StreamBuilder(
      //stream: LocationService().locationStream,
      builder:( context,  asyncSnapshot  ){
        if (asyncSnapshot.hasData) {
          _currentPosition = asyncSnapshot.data;
          _onAddMarker( context, model, _currentPosition);
          return  GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _currentPosition,
            zoom: 16.0,
           ),
           markers: _markers,
           mapType: MapType.normal,
           );
        }else{
          return Center(
          child: CircularProgressIndicator()
        );
        }
      }
    );
  }   
        
  void _showAutoDetectionAlert( BuildContext context, MapSettingViewModel model, LatLng currentPosition, AddressModel address ){
    showDialog(
     context: context,
     barrierDismissible: false,
     builder: ( context ){
       return AlertDialog(
         title: Text('Autodetection'),
         actions: <Widget>[
          FlatButton(
            onPressed: (){
              model.saveAddress( address, currentPosition );
              //model.navigateTo(MapSettingViewRoute);
            }, 
            child: Text('ok')
          ),
          FlatButton(
            onPressed: (){
              //model.navigateTo(MapSettingViewRoute);
            }, 
            child: Text('Check')
          )
         ],
       );
     }
   ); 
  }
}