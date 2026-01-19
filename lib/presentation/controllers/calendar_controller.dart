import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';

class CalendarController extends GetxController {
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;

  RxBool isIslamic = true.obs;

  HijriCalendar get hijriDate =>
      HijriCalendar.fromDate(selectedDay.value);

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }

  void toggleCalendarType() {
    isIslamic.toggle();
  }
}
