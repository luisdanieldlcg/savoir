import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/features/search/controller/restaurant_map_controller.dart';

class RestaurantSearchFilters extends ConsumerStatefulWidget {
  const RestaurantSearchFilters({super.key});

  @override
  ConsumerState<RestaurantSearchFilters> createState() => _RestaurantSearchFiltersState();
}

class _RestaurantSearchFiltersState extends ConsumerState<RestaurantSearchFilters> {
  int _activeFilter = 0;
  @override
  Widget build(BuildContext context) {
    final filterChoices = [
      {
        "name": "Todos",
        "icon": "🍽️",
      },
      {
        "name": "Vegetariano",
        "icon": "🥦",
      },
      {
        "name": "Café",
        "icon": "☕",
      },
      {
        "name": "Cerveza",
        "icon": "🍺",
      },
      {
        "name": "Vino",
        "icon": "🍷",
      },
      {
        "name": "Reserva",
        "icon": "📝",
      }
    ];
    return Row(
      children: [
        ...filterChoices.map(
          (filter) {
            final selected = _activeFilter == filterChoices.indexOf(filter);
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Theme(
                data: ThemeData(),
                child: ChoiceChip(
                  selectedColor: AppTheme.primaryColor,
                  iconTheme: IconThemeData(color: selected ? Colors.white : AppTheme.primaryColor),
                  checkmarkColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: selected ? Colors.transparent : Colors.grey.shade200),
                  ),
                  labelStyle: TextStyle(color: selected ? Colors.white : AppTheme.primaryColor),
                  onSelected: (selected) {
                    setState(() {
                      _activeFilter = filterChoices.indexOf(filter);
                    });
                    ref.read(restaurantMapProvider.notifier).filterByFn((resturant) {
                      switch (_activeFilter) {
                        case 0:
                          return true;
                        case 1:
                          return resturant.servesVegetarianFood;
                        case 2:
                          return resturant.servesCoffee;
                        case 3:
                          return resturant.servesBeer;
                        case 4:
                          return resturant.servesWine;
                        default:
                          return true;
                      }
                    });
                  },
                  selected: selected,
                  label: Text(filter["name"] as String),
                  avatar: filter["icon"] is IconData
                      ? Icon(filter["icon"] as IconData)
                      : Text(filter["icon"] as String),
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
