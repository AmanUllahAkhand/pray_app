import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../core/constants/app_icons.dart';
import '../controllers/calendar_controller.dart';
import '../widgets/custom_text.dart';

class CalendarScreen extends GetView<CalendarController> {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Or your backgroundColor constant
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, 0.81),
            end: Alignment(0.50, -0.38),
            colors: [Color(0x00086055), Color(0xFF96D9CC)],
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
          Obx(() {
            return DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: controller.selectedHijriMonth.value,
                items: List.generate(
                  controller.hijriMonths.length,
                      (index) => DropdownMenuItem<int>(
                    value: index + 1,
                    child: CustomText(
                      text: "${controller.hijriMonths[index]}, ${controller.selectedHijriYear.value}",
                    ),
                  ),
                ),
                selectedItemBuilder: (context) {
                  return List.generate(
                    controller.hijriMonths.length,
                        (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          text: controller.hijriMonthYear,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomText(
                          text: controller.gregorianMonthRange,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  );
                },
                onChanged: (value) {
                  if (value != null) {
                    controller.onHijriMonthChanged(value);
                  }
                },
              ),
            );
          }),

          const Spacer(),

          /// Filter Icon
          SvgPicture.asset(AppIcons.filter, height: 22),
          const SizedBox(width: 12),

          /// Islamic / English Toggle
          Obx(
                () => GestureDetector(
              onTap: controller.toggleCalendarType,
              child: CustomText(
                text: controller.isIslamic.value ? "Islamic" : "English",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
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
        startingDayOfWeek: StartingDayOfWeek.sunday,

        calendarStyle: const CalendarStyle(
          outsideDaysVisible: false,
        ),

        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, _) {
            return _dayCell(day,
                hasEvent: controller.hasEvent(day));
          },
          selectedBuilder: (context, day, _) {
            return _dayCell(day,
                isSelected: true,
                hasEvent: controller.hasEvent(day));
          },
          todayBuilder: (context, day, _) {
            return _dayCell(day,
                isToday: true,
                hasEvent: controller.hasEvent(day));
          },
        ),
      );
    });
  }

  /// 📜 Event List
  Widget _eventList() {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.events.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: CustomText(text: "Islamic Event", fontWeight: FontWeight.w600),
              );
            }

            final event = controller.events[index - 1];

            // Calling the Widget Class and the new Model Getters
            return _EventTile(
              title: event.title,
              hijri: event.formattedHijri,
              date: event.formattedGregorian,
            );
          },
        );
      }),
    );
  }

  /// 🗓️ Custom Day Cell with Event Marker
  Widget _dayCell(
      DateTime day, {
        bool isSelected = false,
        bool isToday = false,
        bool hasEvent = false,
      }) {
    final hijri = HijriCalendar.fromDate(day);

    Color bgColor = Colors.transparent;
    Color hijriColor = Colors.black;
    Color gregorianColor = Colors.grey;

    if (isSelected) {
      bgColor = Get.theme.primaryColor;
      hijriColor = Colors.white;
      gregorianColor = Colors.white70;
    } else if (isToday) {
      bgColor = Get.theme.primaryColor.withOpacity(0.2);
      hijriColor = Get.theme.primaryColor;
    } else if (hasEvent) {
      bgColor = const Color(0xff0A8F79).withOpacity(0.15);
      hijriColor = const Color(0xff0A8F79);
    }

    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: hasEvent
            ? Border.all(color: const Color(0xff0A8F79), width: 1)
            : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 🔁 Toggle View
              if (controller.isIslamic.value) ...[
                CustomText(
                  text: hijri.hDay.toString(),
                  fontWeight: FontWeight.bold,
                  color: hijriColor,
                ),
                CustomText(
                  text: day.day.toString(),
                  fontSize: 11,
                  color: gregorianColor,
                ),
              ] else ...[
                CustomText(
                  text: day.day.toString(),
                  fontWeight: FontWeight.bold,
                  color: hijriColor,
                ),
                CustomText(
                  text: hijri.hDay.toString(),
                  fontSize: 11,
                  color: gregorianColor,
                ),
              ],
            ],
          ),

          /// 🔥 Event Dot
          if (hasEvent)
            Positioned(
              bottom: 4,
              child: Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white
                      : const Color(0xff0A8F79),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

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
              color: const Color(0xff0A8F79),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: title, fontWeight: FontWeight.w500),
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
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }
}

