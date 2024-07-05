import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/features/search/controller/restaurant_reservation_controller.dart';

class TableReservationTimeChips extends ConsumerStatefulWidget {
  const TableReservationTimeChips({super.key});

  @override
  ConsumerState<TableReservationTimeChips> createState() => _TableReservationTimeChipsState();
}

class _TableReservationTimeChipsState extends ConsumerState<TableReservationTimeChips> {
  int selectedTimeIndex = 0;

  DateTime now = DateTime.now();
  void onSelectedTime(int index, String time, ReservationForm form) {
    setState(() {
      selectedTimeIndex = index;
    });

    final hour = time.split(":")[0];
    final minute = time.split(":")[1].split(" ")[0];

    ref.read(reservationFormProvider.notifier).setDateTime(
          form.reservationDate.copyWith(
            hour: int.parse(hour),
            minute: int.parse(minute),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final lunchTimeSlots = [
      "12:00 PM",
      "12:30 PM",
      "1:00 PM",
      "1:30 PM",
      "2:00 PM",
    ];
    final dinnerTimeSlots = [
      "6:00 PM",
      "6:30 PM",
      "7:00 PM",
      "7:30 PM",
      "8:00 PM",
      "9:00 PM",
      "9:30 PM",
      "10:00 PM",
    ];
    final form = ref.watch(reservationFormProvider);
    AppLogger.getLogger(TableReservationTimeChips).i('check: $now');
    return Column(
      children: [
        Text("Almuerzo", style: TextStyle(fontSize: 18)),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...lunchTimeSlots.asMap().entries.map((entry) {
                final i = entry.key;
                final time = entry.value;
                final selected = selectedTimeIndex == i;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Theme(
                    data: ThemeData(),
                    child: ChoiceChip(
                      backgroundColor: Colors.white,
                      selectedColor: AppTheme.primaryColor,
                      iconTheme: IconThemeData(color: Colors.white),
                      checkmarkColor: Colors.white,
                      label: Text(time),
                      labelStyle: TextStyle(color: selected ? Colors.white : AppTheme.textColor),
                      selected: selectedTimeIndex == i,
                      avatar: selected ? Icon(Icons.check, color: Colors.white) : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      // onSelected: (selected) => onSelectedTime(i, time, form),
                      // lock if time is past
                      onSelected: now.isAfter(form.reservationDate)
                          ? (selected) => {onSelectedTime(i, time, form)}
                          : null,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text("Cena", style: TextStyle(fontSize: 18)),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...dinnerTimeSlots.asMap().entries.map((entry) {
                final i = entry.key;
                final time = entry.value;
                final selected = selectedTimeIndex == i + lunchTimeSlots.length;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Theme(
                    data: ThemeData(),
                    child: ChoiceChip(
                      backgroundColor: Colors.white,
                      selectedColor: AppTheme.primaryColor,
                      iconTheme: IconThemeData(color: Colors.white),
                      checkmarkColor: Colors.white,
                      label: Text(time),
                      labelStyle: TextStyle(color: selected ? Colors.white : AppTheme.textColor),
                      avatar: selected ? Icon(Icons.check, color: Colors.white) : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      selected: selectedTimeIndex == i + lunchTimeSlots.length,
                      onSelected: (selected) =>
                          onSelectedTime(i + lunchTimeSlots.length, time, form),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
