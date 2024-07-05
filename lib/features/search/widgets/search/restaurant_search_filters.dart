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
      },
      {
        "name": "Pizza",
        "icon": "🍕",
      },
      {
        "name": "Vegano",
        "icon": "🌱",
      },
      {
        "name": "Chino",
        "icon": "🥡",
      },
      {
        "name": "Mexicano",
        "icon": "🌮",
      },
      {
        "name": "Americano",
        "icon": "🍔",
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
                          for (final type in resturant.types) {
                            switch (_activeFilter) {
                              case 5:
                                return resturant.reservable;
                              case 6:
                                return type.contains("pizza");
                              case 7:
                                return type.contains("vegan");
                              case 8:
                                return type.contains("chinese");
                              case 9:
                                return type.contains("mexican");
                              case 10:
                                return type.contains("american");
                            }
                          }
                          return false;
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
