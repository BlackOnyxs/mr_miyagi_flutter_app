
import 'package:location/location.dart';
import 'package:mr_miyagi_app/core/models/address_model.dart';
import 'package:mr_miyagi_app/core/models/customer_user.dart';
import 'package:mr_miyagi_app/core/models/latlng_model.dart' as nestedLatLng;
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mr_miyagi_app/core/services/auth_service.dart';
import 'package:mr_miyagi_app/core/services/firestore_service.dart';
import 'package:mr_miyagi_app/core/services/navigation_service.dart';
import 'package:mr_miyagi_app/core/utils/routing_constant.dart';

import '../../locator.dart';
import 'base_model.dart';

class LocationSettingViewModel extends BaseModel{
  NavigationService _navigationService = locator<NavigationService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();
  
  geo.Position _currentPosition;
  geo.Position get currentPosition => _currentPosition;


  void getCurrentPosition( AddressModel currentAddress) async{
    setBusy(true);
    final geo.Geolocator geolocator = geo.Geolocator()..forceAndroidLocationManager;
    var result  = await geolocator.isLocationServiceEnabled();
    if (!result){
     getService();
    }else if (result){
    geolocator
    .getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.best)
    .then((geo.Position position){
       _currentPosition = position;
      print('Latitude: ${_currentPosition.latitude}, Longitude: ${_currentPosition.longitude} ');
       
    nestedLatLng.LatLng _nestedLocation = new nestedLatLng.LatLng();
    _nestedLocation.lat = _currentPosition.latitude;
    _nestedLocation.lng = _currentPosition.longitude;
    currentAddress.location = _nestedLocation;
     _authenticationService.isUserLoggedIn().then(( value ){
      if ( value ) {
        if(_authenticationService.currentUser != null){
        CustomerUser  _currentUser = _authenticationService.currentUser;
        _currentUser.address = new List();
        _currentUser.address.add(currentAddress);
        var e = _firestoreService.updateUser( _currentUser );
          if ( e is PlatformException ) {
            print(e);
          }else{
            setBusy(false);
            notifyListeners();
            navigateTo(HOME_VIEW_ROUTE);
          }
        }
      }
    });
    
    }).catchError((e){
      print(e);
    });
    }
  }


  Future<bool> getService() async{
    Location location = new Location();
    bool _permissionGranted = await location.requestService();
    return _permissionGranted;
  }



  void navigateTo( String path, {AddressModel currentAddress} ){
    _navigationService.navigateToPop(path, arg: currentAddress);
  }

}