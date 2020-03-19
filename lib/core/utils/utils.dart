import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_miyagi_app/core/models/address_model.dart';
import 'package:mr_miyagi_app/core/models/customer_user.dart';
import 'package:mr_miyagi_app/core/models/latlng_model.dart';


class Utils {

  /* List<RestaurantModel> builRestaurant(List<DocumentSnapshot> data){
    List<RestaurantModel> restaurants = new List();
    for (var i = 0; i < data.length; i++) {
      RestaurantModel currentRest = new RestaurantModel(
      id            : data[i].data["id"],
      name          : data[i].data["name"],
      description   : data[i].data["description"],
      feedback      : data[i].data["feedback"],
      location      : data[i].data["location"],
      photoUrl      : data[i].data["photoUrl"],
      schedule      : data[i].data["schedule"],
    );
    List<FoodModel> menu = new List();
    List<dynamic> menuData = data[i].data["menu"] as List;
      for (var e = 0; e < menuData.length; e++) {
        FoodModel currentFood = new FoodModel(
          id: menuData[e]["id"],
          name: menuData[e]["name"],
          description: menuData[e]["description"],
          type: menuData[e]["type"],
          price: menuData[e]["price"],
          photoUrl: menuData[e]["photoUrl"],
          model: menuData[e]["model"] 
        );
        List<IngredientModel> ingredients = new List();
        List<dynamic> ingredientsData = menuData[e]["ingredients"] as List;
        for (var j = 0; j < ingredients.length; j++) {
          IngredientModel currentIngredient = new IngredientModel(
            id: ingredientsData[j],
            name: ingredientsData[j]
          );
          ingredients.add(currentIngredient);
        }
        currentFood.ingredients = ingredients;
        List<String> tags = new List();
        List<dynamic> tagsData = data[i].data["tags"] as List;
        for (var k = 0; k < data.length; k++) {
          String currentTag = tagsData[k];
          tags.add(currentTag);
        }
        menu.add(currentFood);
        currentRest.tags = tags;
      }
      List<String> sections = new List();
      List<dynamic> sectiondata = data[i].data["menuSections"];
      for (var l = 0; l < sectiondata.length; l++) {
        String currentSection = sectiondata[l];
        sections.add(currentSection);
      }
      currentRest.menuSections = sections;
      currentRest.menu = menu;
      restaurants.add(currentRest);
    }
    return restaurants;
  }
 */
  CustomerUser fetchUser( DocumentSnapshot data){
    CustomerUser _currentUser = new CustomerUser(
      id: data['id'],
      fullName: data['fullName'],
      photoUrl: data['photoUrl'],
      feedback: data['feedback'],
      email: data['email'], 
    );
    List<AddressModel> _addresses = new List();
    List<dynamic> _addressesData = data['address'] as List;
    if (_addressesData != null) {
      for (var i = 0; i < _addressesData.length; i++) {
      AddressModel _currentAddress = new AddressModel(
        neighborhoodName    : _addressesData[i]['neighborhoodName'],
        streetName          : _addressesData[i]['streetName'],
        houseNumber         : _addressesData[i]['houseNumber'],
        generalDescription  :  _addressesData[i]['generalDescription'],
        type                : _addressesData[i]['type'],
      );
      dynamic _latLngData = _addressesData[i]['location'] as Map;
      LatLng _currentLatLng = new LatLng(
        lat: _latLngData['lat'],
        lng: _latLngData['lng'],
      );
      _currentAddress.location = _currentLatLng;
      _addresses.add(_currentAddress);
      }
    }
    
    _currentUser.address = _addresses;
    List<String> _ordersId = new List();
    List<dynamic> _orderIdData = data['ordersId'] as List;
    if(_orderIdData != null){
      for (var e = 0; e < _orderIdData.length; e++) {
        String _curentOrderId = _orderIdData[e];
        _ordersId.add(_curentOrderId);
      } 
    }
    _currentUser.ordersId = _ordersId;
    return _currentUser;
  }
/* 
  OrderModel fetchOrder( DocumentSnapshot data){
    OrderModel _currentOrder = new OrderModel(
      id              : data['id'],
      customerId      : data['customerId'], 
      employeeId      : data['employeeId'],
      restaurantId    : data['restaurantId'],
      restaurantName  : data['restaurantName'],
      subTotalPrice   : data['subTotalPrice'],
      deliveryPrice   : data['deliveryPrice'],
      totalPrice      : data['totalPrice'],
      state           : data['state'], 
    );
    List<FoodModel> _foods = new List();
    List<dynamic> _foodData = data['localFoods'] as List;
    if ( _foodData != null ) {
      for (var i = 0; i < _foodData.length; i++) {
        FoodModel _currentFood = new FoodModel(
          id          : _foodData[i]['id'],
          type        : _foodData[i]['type'],
          name        :_foodData[i]['name'],
          price       :_foodData[i]['price'],
          photoUrl    :_foodData[i]['photoUrl'],
          model       :_foodData[i]['model'],
          description :_foodData[i]['description'],
          state       :_foodData[i]['state'],
        );
        List<IngredientModel> _ingredients = new List();
        List<dynamic> _ingredientsData = _foodData[i]['ingredients'] as List;
        if ( _ingredientsData != null ) {
          for (var i = 0; i < _ingredientsData.length; i++) {
            IngredientModel _currentIngredient = new IngredientModel(
              id   : _ingredientsData[i]['id'],
              name : _ingredientsData[i]['name']
            );
            _ingredients.add(_currentIngredient);
          }
          _currentFood.ingredients = _ingredients;
        }
        _foods.add(_currentFood);
      }
      _currentOrder.localFoods = _foods;
    }
    dynamic _restLatLngData = data['restaurantLocation'];
    if (_restLatLngData != null ) {
      LatLng _restaurantLocation = new LatLng(
        lat: _restLatLngData['lat'],
        lng: _restLatLngData['lng']
      );
      _currentOrder.restaurantLocation = _restaurantLocation;
    }
    dynamic _userLatLng = data['userAddress'];
    if (_userLatLng != null ) {
      AddressModel _currentAddress = new AddressModel(
        neighborhoodName    : _userLatLng['neighborhoodName'],
        streetName          : _userLatLng['streetName'],
        houseNumber         : _userLatLng['houseNumber'],
        generalDescription  : _userLatLng['generalDescription'],
        type                : _userLatLng['type'],
      );
      LatLng _userLocation = new LatLng(
        lat: _restLatLngData['lat'],
        lng: _restLatLngData['lng']
      );
      _currentAddress.location = _userLocation;
    }
  return _currentOrder;
  } */
}