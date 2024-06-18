import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/rounded_text_input.dart';
import 'package:savoir/common/widgets/user_avatar.dart';
import 'package:savoir/router.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  static final exampleRestaurants = [
    {
      "name": "La Cassina",
      "image":
          "https://cdn.sortiraparis.com/images/80/100789/834071-too-restaurant-too-hotel-paris-photos-menu-entrees.jpg",
      "location": "Av. Winston Churchill",
      "stars": 4
    },
    {
      "name": "Pizzeria Ristorante",
      "image": "https://www.glint-berlin.de/wp-content/uploads/2019/04/Berlin-Mitte-Restaurant.jpg",
      "location": "Av. Gustavo Mejía Ricart, Piantini",
      "stars": 5
    },
    {
      "name": "Café Barista",
      "image": "https://cdn.vox-cdn.com/uploads/chorus_image/image/62582192/IMG_2025.280.jpg",
      "location": "C. 14 de Junio",
      "stars": 3
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = getUserOrLogOut(ref, context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: const Text(
            'Explora',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        toolbarHeight: 144,
        titleSpacing: 18,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              RoundedTextInput(
                hintText: 'Buscar restaurantes',
                leftIcon: Icon(Icons.search),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 36),
            child: UserAvatar(
              imageSrc: user!.profilePicture,
              radius: 24,
              withBorder: false,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Text(
              "Restaurantes cerca de ti",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  "¡Déjà vu!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.location_on_outlined,
                    size: 28,
                  ),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRouter.restaurantsMap,
                  ),
                  color: AppTheme.primaryColor,
                )
              ],
            ),
            const SizedBox(height: 20),
            ListView.builder(
              itemCount: exampleRestaurants.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final restaurant = exampleRestaurants[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(restaurant["image"] as String),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 200,
                      ),
                      ListTile(
                        title: Text(
                          restaurant["name"] as String,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: [
                            Icon(Icons.location_on, color: AppTheme.primaryColor),
                            Expanded(
                              child: Text(
                                restaurant["location"] as String,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              5,
                              (index) => Icon(
                                Icons.star,
                                color: index < (restaurant["stars"] as int)
                                    ? AppTheme.primaryColor
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
