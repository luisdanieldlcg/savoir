import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';
import 'package:savoir/features/search/model/restaurant_details.dart';

class RestaurantDetailsInfoTab extends StatelessWidget {
  final RestaurantSummary restaurant;
  final RestaurantDetails details;
  const RestaurantDetailsInfoTab({
    super.key,
    required this.restaurant,
    required this.details,
  });

  void onPhoneNumberTapped(String phoneNumber) => launchExternalApp("tel:+$phoneNumber");
  void onWebsiteTapped(String website) => launchExternalApp(website);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          "Sobre \"${restaurant.name}\":",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          details.editorialSummary == null
              ? "No hay información disponible"
              : details.editorialSummary!.overview,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Contacto: ",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () => onPhoneNumberTapped(details.internationalPhoneNumber),
          child: ListTile(
            minTileHeight: 44,
            leading: Icon(Icons.phone, color: AppTheme.primaryColor),
            title: Text(
              details.internationalPhoneNumber,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        if (details.website != null)
          // this link should be clickable
          InkWell(
            onTap: () => onWebsiteTapped(details.website!),
            child: ListTile(
              minTileHeight: 44,
              leading: Icon(Icons.web, color: AppTheme.primaryColor),
              title: Text(
                details.website!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        const SizedBox(height: 20),
        Text("Horarios", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        if (details.openingHours == null) ...{
          const Text("No hay información disponible"),
        } else ...{
          DataTable(
            border: TableBorder.all(color: Colors.grey.shade300),
            dividerThickness: 0.5,
            headingRowHeight: 40,
            headingRowColor: WidgetStatePropertyAll(AppTheme.primaryColor),
            headingTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            columns: const [
              DataColumn(label: Text("Día")),
              DataColumn(label: Text("Horario")),
            ],
            rows: details.openingHours == null
                ? const [
                    DataRow(cells: [
                      DataCell(Text("No hay información disponible")),
                      DataCell(Text("")),
                    ]),
                  ]
                : details.openingHours!.weekdayText.map(
                    (e) {
                      final parts = e.split(": ");
                      return DataRow(
                        cells: [
                          DataCell(Text(parts[0])),
                          DataCell(Text(parts[1])),
                        ],
                      );
                    },
                  ).toList(),
          ),
        }
      ],
    );
  }
}
