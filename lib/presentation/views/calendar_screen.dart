import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hijri/hijri_calendar.dart';
import '../controllers/calendar_controller.dart';
import '../widgets/custom_text.dart';


class CalendarScreen extends GetView<CalendarController> {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, 0.81),
            end: Alignment(0.50, -0.38),
            colors: [const Color(0x00086055), const Color(0xFF96D9CC)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _topBar(),
              _calendar(),
              _eventList(),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔝 Top Bar
  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.arrow_back),

          const SizedBox(width: 8),

          /// Month Dropdown
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: "Muharram, 1447",
              items: const [
                DropdownMenuItem(
                  value: "Muharram, 1447",
                  child: CustomText(text: "Muharram, 1447"),
                ),
              ],
              onChanged: (_) {},
            ),
          ),

          const Spacer(),

          /// Filter Icon
          SvgPicture.asset(
            'assets/icons/filter.svg',
            height: 22,
          ),

          const SizedBox(width: 12),

          /// Islamic / English Toggle
          Obx(() => GestureDetector(
            onTap: controller.toggleCalendarType,
            child: CustomText(
              text: controller.isIslamic.value
                  ? "Islamic"
                  : "English",
              fontWeight: FontWeight.w600,
            ),
          )),
        ],
      ),
    );
  }

  /// 📅 Calendar
  Widget _calendar() {
    return Obx(() {
      return TableCalendar(
        firstDay: DateTime(2020),
        lastDay: DateTime(2030),
        focusedDay: controller.focusedDay.value,
        selectedDayPredicate: (day) =>
            isSameDay(controller.selectedDay.value, day),
        onDaySelected: controller.onDaySelected,
        headerVisible: false,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, _) {
            final hijri = HijriCalendar.fromDate(day);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Arabic Date (Bold)
                CustomText(
                  text: hijri.hDay.toString(),
                  fontWeight: FontWeight.bold,
                ),

                /// English Date
                CustomText(
                  text: day.day.toString(),
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ],
            );
          },
        ),
      );
    });
  }

  /// 📜 Event List
  Widget _eventList() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          CustomText(
            text: "Islamic Event",
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 12),
          _EventTile(
            title: "Ashura",
            hijri: "10 Muharram, 1447",
            date: "17 July, 2025",
          ),
          _EventTile(
            title: "Prophet Muhammad’s Birthday",
            hijri: "12 Rabi al-Awwal, 1447",
            date: "28 September, 2025",
          ),
        ],
      ),
    );
  }
}

/// 📌 Event Tile
class _EventTile extends StatelessWidget {
  final String title;
  final String hijri;
  final String date;

  const _EventTile({
    required this.title,
    required this.hijri,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: title),
                CustomText(
                  text: hijri,
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          CustomText(
            text: date,
            fontSize: 11,
          ),
        ],
      ),
    );
  }
}
