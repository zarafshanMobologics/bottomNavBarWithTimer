import 'dart:developer';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

class BottomNavigationController extends GetxController {
  final RxInt _pageIndex = 0.obs;
  SharedPreferences? _prefs;
  bool isFirstTime = true;
  late DateTime? firstVisitDateTime;
  final RxBool _meet = false.obs;
  late Timer _timer; // Declare timer variable

  final dateFormatter = DateFormat('yyyy-MM-dd');
  final timeFormatter = DateFormat('HH:mm:ss');

  @override
  void onInit() async {
    super.onInit();
    log('init start');
    //loadPrefs();

    // Start the timer after a delay of 1 minute (60 seconds)
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      loadPrefs();
      print('rebuilding');
    });
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel(); // Cancel the timer when the controller is closed
  }

  Future<void> loadPrefs() async {
    log('init start');
    _prefs = await SharedPreferences.getInstance();
    isFirstTime = _prefs!.getBool('isFirstTime') ?? true;
    log("first time $isFirstTime");
    if (!isFirstTime) {
      final int storedTimeStamp = _prefs!.getInt('firstVisitDateTime') ??
          DateTime.now().millisecondsSinceEpoch;
      firstVisitDateTime = DateTime.fromMillisecondsSinceEpoch(storedTimeStamp);

      final differenceInMins =
          DateTime.now().difference(firstVisitDateTime!).inMinutes;
      print('Stored Timestamp: $storedTimeStamp');
      print('First Visit Date Time: $firstVisitDateTime');
      print('Current Time: ${DateTime.now()}');
      print('Difference in Minutes: $differenceInMins');
      print("condition meet the time: $_meet");
      if (differenceInMins >= 1) {
        _meet.value = true;
        print(_meet.value);
        update();
        _pageIndex.value = 3;
        // Trigger UI update when condition is met
      } else {
        _pageIndex.value = 2;
        print(_meet.value);
      }
    } else {
      firstVisitDateTime = DateTime.now();
      _prefs!.setInt(
          'firstVisitDateTime', firstVisitDateTime!.millisecondsSinceEpoch);
      _prefs!.setBool('isFirstTime', false);
      _pageIndex.value = 2;
    }
  }

  void changePageTab(int index) {
    _pageIndex.value = index;
    _prefs?.setInt('firstVisitDateTime', DateTime.now().millisecondsSinceEpoch);
  }

  bool get meet => _meet.value;

  int get pageIndex => _pageIndex.value;
}
