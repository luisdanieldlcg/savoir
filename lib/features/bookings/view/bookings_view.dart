import 'package:flutter/material.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/features/bookings/tabs/active_bookings_tab.dart';
import 'package:savoir/features/bookings/tabs/history_bookings_tab.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 18,
        title: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: title("Reservas"),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        // child: child,
        // Activas, Historial
        child: Column(
          children: const [
            TabBar(
              dividerHeight: 0,
              tabs: [
                Tab(text: 'Activas'),
                Tab(text: 'Historial'),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                children: [
                  ActiveBookingsTab(),
                  HistoryBookingsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
