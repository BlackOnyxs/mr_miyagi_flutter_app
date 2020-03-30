
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mr_miyagi_app/core/models/address_model.dart';
import 'package:mr_miyagi_app/core/models/customer_user.dart';
import 'package:mr_miyagi_app/core/models/latlng_model.dart' as nestedLatLng;
import 'package:mr_miyagi_app/core/services/auth_service.dart';
import 'package:mr_miyagi_app/core/services/firestore_service.dart';
import 'package:mr_miyagi_app/core/services/navigation_service.dart';

import '../../locator.dart';
import 'base_model.dart';

class MapSettingViewModel extends BaseModel{
  FirestoreService _firestoreService = locator<FirestoreService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();

  LatLng _position;
  LatLng get position => _position;

  void saveAddress( AddressModel addressModel, LatLng currentPosition  ) async {
    setBusy(true);

    nestedLatLng.LatLng _nestedLocation = new nestedLatLng.LatLng();
    _nestedLocation.lat = currentPosition.latitude;
    _nestedLocation.lng = currentPosition.longitude;
    addressModel.location = _nestedLocation;

    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    CustomerUser _currentUser;
    
    if(hasLoggedInUser){
      var uid =_authenticationService.currentUser.id;

      try {
        _currentUser =  await _firestoreService.getUser(uid);
        _currentUser.address = new List();
        _currentUser.address.add(addressModel);
      } catch (e) {
        print("Can't get User $uid $e");
      }
      
      await _firestoreService.updateUser( _currentUser );
      setBusy(false);
      notifyListeners();
    }
  }

  void navigateTo(String path, {String arg}){
    _navigationService.navigateToPop(path, arg: arg);
  }

}