import 'package:flutter/services.dart';
import 'package:mr_miyagi_app/core/models/daily_lunch_model.dart';
import 'package:mr_miyagi_app/core/services/firestore_service.dart';
import 'package:mr_miyagi_app/core/services/navigation_service.dart';
import 'package:mr_miyagi_app/core/viewmodels/base_model.dart';
import 'package:mr_miyagi_app/locator.dart';
import 'package:rxdart/rxdart.dart';

class DailyLunchViewModel extends BaseModel{
  FirestoreService _firestoreService = locator<FirestoreService>();
  NavigationService _navigationService = locator<NavigationService>();

  final _dailyLunchController = BehaviorSubject<List<DailyLunchModel>>();
  Stream<List<DailyLunchModel>> get dailyLunchStream => _dailyLunchController.stream;

  Future listenDailyLunch() async{
    try {
      setBusy(true);
       _firestoreService.listenDailyLunch().listen((onData){
        _dailyLunchController.sink.add(onData);
        notifyListeners();
       });
      setBusy(false);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
    }
  }

  navigateTo(String path, DailyLunchModel dailyLunch){
    _navigationService.navigateToPush(path, arg: dailyLunch);
  }

  void dispose(){
    _dailyLunchController?.close();
  }
}