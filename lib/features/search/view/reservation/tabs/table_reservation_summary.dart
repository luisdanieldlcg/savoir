import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/widgets/pulse_progress_indicator.dart';
import 'package:savoir/features/search/controller/restaurant_reservation_controller.dart';

class TableReservationSummary extends ConsumerStatefulWidget {
  const TableReservationSummary({super.key});

  @override
  ConsumerState<TableReservationSummary> createState() => _TableReservationSummaryState();
}

class _TableReservationSummaryState extends ConsumerState<TableReservationSummary> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return true
        ? PulseProgressIndicator()
        : ListView(
            children: [
              const SizedBox(height: 24),
              Center(
                  child: Text("Resumen de reserva",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              const SizedBox(height: 16),
              // make invoice summary
              ListTile(
                title: Text("Fecha y hora",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                trailing: Text(
                  ref.watch(reservationFormProvider).reservationDate.toString().substring(0, 16),
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                title:
                    Text("Personas", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                trailing: Text(ref.watch(reservationFormProvider).numberOfPeople.toString(),
                    style: TextStyle(fontSize: 15)),
              ),
              ListTile(
                title:
                    Text("Duración", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                trailing: Text(
                  "${ref.watch(reservationFormProvider).durationHours}${ref.watch(reservationFormProvider).durationHours > 1 ? ' horas' : ' hora'}",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                title: Text("Instrucciones",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                trailing: GestureDetector(
                  onTap: () {
                    // show instructions dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Instrucciones"),
                          content: Text(ref.watch(reservationFormProvider).instructions),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cerrar"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    "Ver instrucciones",
                    style: TextStyle(fontSize: 14, color: AppTheme.primaryColor),
                  ),
                ),
              ),
              ListTile(
                title: Text("Cuota de reserva",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                trailing: Text("RD\$300.00", style: TextStyle(fontSize: 15)),
              ),

              // total
              TextButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  ref.read(reservationFormProvider.notifier).makeReservation();
                  setState(() {
                    loading = false;
                  });
                },
                child: Text(
                  "Reservar por RD\$300.00",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
  }
}
