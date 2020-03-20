import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:mr_miyagi_app/core/models/address_model.dart';
import 'package:mr_miyagi_app/core/services/navigation_service.dart';
import 'package:mr_miyagi_app/core/utils/routing_constant.dart';
import 'package:mr_miyagi_app/core/utils/validators.dart';
import '../../locator.dart';
import 'base_model.dart';

class SettingViewModel extends BaseModel with Validators{
  NavigationService _navigationService = locator<NavigationService>();

  final _neighborhoodController = BehaviorSubject<String>();
  final _streetController       = BehaviorSubject<String>();
  final _houseController        = BehaviorSubject<String>();
  final _generalController      = BehaviorSubject<String>();

  Stream<String> get neighborhoodStream => _neighborhoodController.stream.transform( validateEmptyField );
  Stream<String> get streetStream       => _streetController.stream.transform( validateEmptyField );
  Stream<String> get houseStream        => _houseController.stream.transform( validateEmptyField );
  Stream<String> get generalStream      => _generalController.stream.transform( validateEmptyField );
  Stream<bool>   get validateForm       => 
    CombineLatestStream.combine4(neighborhoodStream, streetStream, houseStream, generalStream, (n,s,h,g) => true);
  Function(String)  get neighborhoodChange  => _neighborhoodController.sink.add;
  Function(String)  get streetChange        => _streetController.sink.add;
  Function(String)  get houseChange         => _houseController.sink.add;
  Function(String)  get generalChange       => _generalController.sink.add; 
  
  String get neigborhood => _neighborhoodController.value;      
  String get street      => _streetController.value;      
  String get house       => _houseController.value;      
  String get general     => _generalController.value;      

  AddressModel createAddress({@required String neighborHoodN, @required String streetN,
                 @required String houseN, @required String genaralDescription}){
    AddressModel newAddress = new AddressModel(
      neighborhoodName: neighborHoodN,
      streetName: streetN,
      houseNumber: houseN,
      generalDescription: genaralDescription,
      type: 'primary'
    );
    return newAddress;
  }

  void navigateTo( String path, {AddressModel arg} ){
    switch (path) {
      case HOME_VIEW_ROUTE:
          _navigationService.navigateToPop(path);
        break;
      /* case MapSettingViewRoute:
          _navigationService.navigateToPush(path, arg: arg );
          break; */
      case LOCATION_SETTINGS_VIEW_ROUTE:
        _navigationService.navigateToPop(path, arg: arg);
        break;
      case HOME_VIEW_ROUTE:
        _navigationService.navigateToPop(path);
        break;
    }
  }


  dispose(){
    _neighborhoodController?.close();
    _streetController?.close();
    _houseController?.close();
    _generalController?.close();
  }

}

/*   initLocationService( ) async {
    _locationService = locator<LocationService>();
    _currentPosition = await _locationService.getLocation();
    if ( _currentPosition != null && _currentAddress != null) {
    nestedLatLng.LatLng _nestedLocation = new nestedLatLng.LatLng();
    _nestedLocation.lat = _currentPosition.latitude;
    _nestedLocation.lng = _currentPosition.longitude;
    _currentAddress.location = _nestedLocation;
    print(_currentAddress.toString());
    }
  } */