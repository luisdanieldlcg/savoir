import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/features/search/controller/restaurant_reservation_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class TableReservationDateTab extends ConsumerWidget {
  const TableReservationDateTab({super.key});

  void onDaySelected(DateTime selectedDay, DateTime focusedDay, WidgetRef ref) {
    // update the focused day to selected day
    ref.read(reservationFormProvider.notifier).setDateTime(selectedDay);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(reservationFormProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TableCalendar(
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          focusedDay: DateTime.now(),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          selectedDayPredicate: (day) => isSameDay(form.reservationDate, day),
          availableGestures: AvailableGestures.all,
          locale: 'es_ES',
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.3),
              shape: BoxShape.circle,
              // make it smaller
            ),
            selectedDecoration: BoxDecoration(
              color: AppTheme.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          onDaySelected: (selectedDay, focusedDay) => onDaySelected(selectedDay, focusedDay, ref),
        ),
      ],
    );
  }
}
