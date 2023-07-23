import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PostCalendarWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final bool showCalendar;
  final List<String> days;
  final String formattedDate;
  final Function(DateTime, DateTime) onDaySelected;
  final VoidCallback onPressdConfirm;
  final VoidCallback onToggleCalendar;

  const PostCalendarWidget({
    required this.focusedDay,
    required this.selectedDay,
    required this.showCalendar,
    required this.days,
    required this.formattedDate,
    required this.onDaySelected,
    required this.onPressdConfirm,
    required this.onToggleCalendar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onToggleCalendar,
          child: Container(
            width: 300,
            height: 60.0,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              formattedDate,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
        AnimatedContainer(
          height: showCalendar ? 400 : 0,
          duration: Duration(milliseconds: 250),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TableCalendar(
                  locale: 'ko-KR',
                  firstDay: DateTime.utc(2021, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: focusedDay,
                  selectedDayPredicate: (DateTime day) {
                    return isSameDay(selectedDay, day);
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    dowBuilder: (context, day) {
                      return Center(child: Text(days[day.weekday]));
                    },
                  ),
                  onDaySelected: onDaySelected,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: onPressdConfirm,
                      child: Text(
                        '확인',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
