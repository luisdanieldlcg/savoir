import 'package:flutter/material.dart';
import 'package:savoir/features/search/view/reservation/widgets/table_reservation_time_chips.dart';

class TableReservationTimeTab extends StatelessWidget {
  const TableReservationTimeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 16),
        TableReservationTimeChips(),
        SizedBox(height: 16),
      ],
    );
  }
}
