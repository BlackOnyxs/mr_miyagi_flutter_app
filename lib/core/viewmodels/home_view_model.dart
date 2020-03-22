import 'package:flutter/services.dart';
import 'package:mr_miyagi_app/core/models/daily_lunch_model.dart';
import 'package:mr_miyagi_app/core/models/food_model.dart';
import 'package:mr_miyagi_app/core/models/ingredient_model.dart';
import 'package:mr_miyagi_app/core/models/menu_section_base.dart';
import 'package:mr_miyagi_app/core/models/menu_section_model.dart';
import 'package:mr_miyagi_app/core/models/promotion_model.dart';
import 'package:mr_miyagi_app/core/services/firestore_service.dart';
import 'package:mr_miyagi_app/core/services/navigation_service.dart';

import '../../locator.dart';
import 'base_model.dart';

class HomeViewModel extends BaseModel{
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<PromotionModel> _promotions;
  List<PromotionModel> get promotions => _promotions;

  List<MenuSectionBase> _sections;
  List<MenuSectionBase> get sections => _sections;

  Future fetchPromotions() async{
    try {
       setBusy(true);
      _firestoreService.listenPromotions().listen((promotionsData){
        List<PromotionModel> updatePromotions = promotionsData;
        if (updatePromotions != null && updatePromotions.length > 0) {
          _promotions = updatePromotions;
           notifyListeners();
        }

        setBusy(false);
      });
    } catch (e) {
      if(e is PlatformException){
        return e.message;
      }
    }
  }
   Future fetchServiceSections()async {
     setBusy(true);
    var sectionsResults = await _firestoreService.getHomeSectionsOnceOff();
    
    if (sectionsResults is List<MenuSectionBase>) {
      _sections = sectionsResults;
      notifyListeners();
    } 
    setBusy(false);
  }
  
  void navigateTo(String path, {String arg}){
    _navigationService.navigateToPush(path, arg: arg);
  }
  void createMenuSection() async {
     FoodModel sushimiPulpo = new FoodModel(
      id: '1',
      description: 'Five (5) fine cuts of a tender and fresh octopus accompanied by a touch of lemon and ginger',
      name: 'Octopus Sashimi ',
      price: '8.75', 
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/darktechdev.appspot.com/o/mr_miyagi%2Fsashimi.jpg?alt=media&token=ecc4a3a1-8452-4baa-aae7-0aa911f3bb55'
    );
    FoodModel sushimiFF = new FoodModel(
      id: '2',
      description: 'Five (5) cuts of a fresh catch and brought to your table to delight your palate, with an exquisite bath in lemon juice',
      name: 'Fresh Fishimg Sashimi',
      price: '8.75',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/darktechdev.appspot.com/o/mr_miyagi%2Fnigiris.jpg?alt=media&token=a3453949-7237-4ace-b8f1-b50ea9412fe1'
    );
    FoodModel sushimiAtun = new FoodModel(
      id: '3',
      description: 'Five (5) slices of rich and juicy fresh tuna gently dipped in lemon and ginger',
      name: 'Tuna Sashimi',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/darktechdev.appspot.com/o/mr_miyagi%2Fmakinoris.jpg?alt=media&token=35f96064-04e8-4d85-ac77-e9a5eee53e8a'
    );
    FoodModel sushimiSalmon = new FoodModel(
      id: '4',
      description: 'Five (5) cuts of our salmon of the day gently dipped in lemon and treated with the finest cuts of our chef',
      name: 'Salmon Sashimi',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/darktechdev.appspot.com/o/mr_miyagi%2Fnigiris.jpg?alt=media&token=a3453949-7237-4ace-b8f1-b50ea9412fe1'
    );
    FoodModel sushimiShrimp = new FoodModel(
      id: '0',
      description: 'Five (5) fine and exquisite delicate cuts of lime-cured shrimp',
      name: 'Shrimp Sashimi',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/darktechdev.appspot.com/o/mr_miyagi%2Fnigiris.jpg?alt=media&token=a3453949-7237-4ace-b8f1-b50ea9412fe1'
    );
    List<FoodModel> foods = new List();
    foods.add(sushimiPulpo);
    foods.add(sushimiFF);
    foods.add(sushimiAtun);
    foods.add(sushimiSalmon);
    foods.add(sushimiShrimp);
    MenuSection sashimi = new MenuSection(
      id: '0',
      displayName: 'Sashimi',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/darktechdev.appspot.com/o/mr_miyagi%2Fsashimi.jpg?alt=media&token=ecc4a3a1-8452-4baa-aae7-0aa911f3bb55',
      foods: foods,
    );
    MenuSection nigiris = new MenuSection(
      id: '1',
      displayName: 'Nigiris',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/darktechdev.appspot.com/o/mr_miyagi%2Fnigiris.jpg?alt=media&token=a3453949-7237-4ace-b8f1-b50ea9412fe1',
      foods: foods,
    );
    MenuSection makinoris = new MenuSection(
      id: '2',
      displayName: 'Makinoris',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/darktechdev.appspot.com/o/mr_miyagi%2Fmakinoris.jpg?alt=media&token=35f96064-04e8-4d85-ac77-e9a5eee53e8a',
      foods: foods,
    );
    MenuSection sushiRoll = new MenuSection(
      id: '3',
      displayName: 'Sushi Roll',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/darktechdev.appspot.com/o/mr_miyagi%2Froll.jpg?alt=media&token=7f709434-2c62-4c5e-b6a7-cc1f0531e0c0',
      foods: foods,
    );
    await _firestoreService.createMenuSection(sashimi);
    await _firestoreService.createMenuSection(nigiris);
    await _firestoreService.createMenuSection(makinoris);
    await _firestoreService.createMenuSection(sushiRoll);
  }
  /* void createDailyLunch() async{
    IngredientModel chicken = new IngredientModel(
      id: '0',
      name: 'Chicken',
      price: '2.50'
    );
    IngredientModel lentils = new IngredientModel(
      id: '1',
      name: 'Lentils',
      price: '0.50'
    );
    IngredientModel rice = new IngredientModel(
      id: '2',
      name: 'Rice',
      price: '0.50'
    );
    List<IngredientModel> ingredients = new List();
    ingredients.add(chicken);
    ingredients.add(lentils);
    ingredients.add(rice);
    FoodModel food = new FoodModel(
      id: '0',
      ingredients: ingredients,
      name: 'Rice With french egg',
      price: '3.50',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/darktechdev.appspot.com/o/mr_miyagi%2Flunch.jpg?alt=media&token=e9df3dad-c220-460a-a668-14d5ebc7b8df'
    );
    
    DailyLunchModel complete = new DailyLunchModel(
      displayName: 'Complete Lunch',
      id: '0',
      food: food
    );

    IngredientModel spinach = new IngredientModel(
      id: '0',
      name: 'Spinach',
      price: '1.50'
    );
    IngredientModel blueberries = new IngredientModel(
      id: '1',
      name: 'Blueberries',
      price: '0.50'
    );
    IngredientModel potatoes = new IngredientModel(
      id: '2',
      name: 'Mashed Potatoes',
      price: '0.50'
    );
    List<IngredientModel> ingredientsF = new List();
    ingredientsF.add(spinach);
    ingredientsF.add(blueberries);
    ingredientsF.add(potatoes);
    FoodModel foodF = new FoodModel(
      id: '0',
      ingredients: ingredientsF,
      name: 'Spinach Salad with Mashed Potatoes',
      price: '3.50',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/darktechdev.appspot.com/o/mr_miyagi%2Ffit-lunch.jpg?alt=media&token=558a9ee8-a8bb-4ca8-a86d-f722852c2660'
    );
    
    DailyLunchModel fitLunch = new DailyLunchModel(
      displayName: 'Fit Lunch',
      id: '0',
      food: foodF
    );
    await _firestoreService.createDailyLunch(complete);
    await _firestoreService.createDailyLunch(fitLunch);
    
  } */

/*   @override
  void dispose() { 
    super.dispose();
    _firestoreService.dipose();
  } */
}