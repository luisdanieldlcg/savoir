import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/features/search/controller/restaurant_reservation_controller.dart';

class TableReservationPeopleTab extends ConsumerStatefulWidget {
  const TableReservationPeopleTab({super.key});

  @override
  ConsumerState<TableReservationPeopleTab> createState() => _TableReservationPeopleTabState();
}

class _TableReservationPeopleTabState extends ConsumerState<TableReservationPeopleTab> {
  final _instructionsController = TextEditingController();

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(reservationFormProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Personas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // -
                        IconButton(
                          icon: Icon(Icons.remove, color: AppTheme.primaryColor),
                          onPressed: () =>
                              ref.read(reservationFormProvider.notifier).decNumberOfPeople(),
                        ),
                        Text(form.numberOfPeople.toString()),
                        IconButton(
                          icon: Icon(Icons.add, color: AppTheme.primaryColor),
                          onPressed: () =>
                              ref.read(reservationFormProvider.notifier).incNumberOfPeople(),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // duration
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Duración", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // -
                        IconButton(
                          icon: Icon(Icons.remove, color: AppTheme.primaryColor),
                          onPressed: () =>
                              ref.read(reservationFormProvider.notifier).decDurationHours(),
                        ),
                        Text("${form.durationHours}${form.durationHours > 1 ? " horas" : " hora"}"),
                        IconButton(
                          icon: Icon(Icons.add, color: AppTheme.primaryColor),
                          onPressed: () =>
                              ref.read(reservationFormProvider.notifier).incDurationHours(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text("Instrucciones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // add a large text field for instructions
          const SizedBox(height: 16),

          TextField(
            controller: _instructionsController,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: "Ej: Mesa cerca de la ventana",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            onChanged: (value) {
              ref.read(reservationFormProvider.notifier).withInstructions(value);
            },
          ),
        ],
      ),
    );
  }
}
