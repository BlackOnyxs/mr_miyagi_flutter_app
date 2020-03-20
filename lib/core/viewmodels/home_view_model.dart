import 'package:flutter/services.dart';
import 'package:mr_miyagi_app/core/models/menu_section_base.dart';
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

/*   @override
  void dispose() { 
    super.dispose();
    _firestoreService.dipose();
  } */
}