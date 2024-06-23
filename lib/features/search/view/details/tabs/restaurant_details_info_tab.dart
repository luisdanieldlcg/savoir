import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/features/search/model/place.dart';
import 'package:savoir/features/search/model/restaurant_details.dart';

class RestaurantDetailsInfoTab extends StatelessWidget {
  final Restaurant restaurant;
  final RestaurantDetails details;
  const RestaurantDetailsInfoTab({
    super.key,
    required this.restaurant,
    required this.details,
  });

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
          onTap: () {},
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
            onTap: () {
              // open the website
              // TODO: implement launch url
            },
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
        Text("Horarios", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(
          details.openingHours == null
              ? "No hay información disponible"
              : details.openingHours!.weekdayText.join("\n"),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
