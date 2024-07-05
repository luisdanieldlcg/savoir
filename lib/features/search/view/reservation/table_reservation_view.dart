import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';
import 'package:savoir/features/search/controller/restaurant_reservation_controller.dart';
import 'package:savoir/features/search/view/reservation/tabs/table_reservation_date_tab.dart';
import 'package:savoir/features/search/view/reservation/tabs/table_reservation_people_tab.dart';
import 'package:savoir/features/search/view/reservation/tabs/table_reservation_time_tab.dart';
import 'package:savoir/features/search/view/reservation/tabs/table_reservation_summary.dart';
import 'package:savoir/features/search/widgets/reservation/table_reservation_appbar.dart';

class TableReservationView extends ConsumerStatefulWidget {
  final RestaurantSummary summary;

  const TableReservationView({super.key, required this.summary});

  @override
  ConsumerState<TableReservationView> createState() => _TableReservationViewState();
}

class _TableReservationViewState extends ConsumerState<TableReservationView> {
  @override
  void initState() {
    super.initState();
    // ref.read(reservationFormProvider.notifier).setRestaurantId(widget.summary.placeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TableReservationAppBar(summary: widget.summary),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: "Reservar mesa en ",
                  style: const TextStyle(fontSize: 24, color: Colors.black),
                  children: [
                    TextSpan(
                      text: widget.summary.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(
                "C'est simple comme bonjour!",
                style: const TextStyle(fontSize: 16, color: AppTheme.textColor),
              ),
              const SizedBox(height: 12),
              DefaultTabController(
                length: 4,
                child: Column(
                  children: const [
                    TabBar(
                      labelColor: AppTheme.primaryColor,
                      unselectedLabelColor: AppTheme.textColor,
                      indicatorColor: AppTheme.primaryColor,
                      dividerHeight: 0,
                      tabs: [
                        Tab(icon: Icon(Icons.calendar_today, size: 20)),
                        Tab(icon: Icon(Icons.access_time, size: 20)),
                        Tab(icon: Icon(Icons.people, size: 20)),
                        Tab(icon: Icon(Icons.list_alt, size: 20)),
                      ],
                    ),
                    SizedBox(
                      height: 400,
                      child: TabBarView(
                        children: [
                          TableReservationDateTab(),
                          TableReservationTimeTab(),
                          TableReservationPeopleTab(),
                          TableReservationSummary(),
                        ],
                      ),
                    ),
                    // tab views
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
