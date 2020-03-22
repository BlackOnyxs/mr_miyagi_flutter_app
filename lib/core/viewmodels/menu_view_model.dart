import 'package:mr_miyagi_app/core/models/menu_section_base.dart';
import 'package:mr_miyagi_app/core/models/menu_section_model.dart';
import 'package:mr_miyagi_app/core/services/dialog_service.dart';
import 'package:mr_miyagi_app/core/services/firestore_service.dart';
import 'package:mr_miyagi_app/core/services/navigation_service.dart';
import 'package:mr_miyagi_app/core/utils/routing_constant.dart';
import 'package:mr_miyagi_app/core/viewmodels/base_model.dart';
import 'package:mr_miyagi_app/locator.dart';
import 'package:rxdart/subjects.dart';

class MenuViewModel extends BaseModel{
  FirestoreService _firestoreService = locator<FirestoreService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  final _sectionController = new BehaviorSubject<List<MenuSection>>();
  Stream<List<MenuSection>> get sectionStream => _sectionController.stream;

  Future getMenuSections()async{
   setBusy(true);
   var menuSections = await _firestoreService.getMenuSections(); 
   setBusy(false);
   if (menuSections is List<MenuSection>) {
     _sectionController.sink.add(menuSections);
     notifyListeners();
   }else{
     await _dialogService.showDialog(
        title: 'Sections Update Failed',
        description: menuSections
    );
   }

  }

  void navigateTo( String path, {dynamic arg }){
    _navigationService.navigateToPush(MENU_SECTION_DETAIL_ROUTE, arg: arg);
  }

  void dispose(){
    _sectionController?.close();
  }
  
}