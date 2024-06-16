import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/router.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  static final _settings = [
    {
      "title": "Datos Personales",
      "icon": Icons.person,
      "onTap": (ctx) {
        Navigator.of(ctx).pushNamed(AppRouter.personalDetails);
      },
    },
    {
      "title": "Métodos de pago",
      "icon": Icons.credit_card,
      "onTap": (ctx) {},
    },
    {
      "title": "Preferencias de comida",
      "icon": Icons.fastfood,
      "onTap": (ctx) {},
    },
    {
      "title": "Ver estadísticas",
      "icon": Icons.bar_chart,
      "onTap": (ctx) {},
    },
    {
      "title": "Favoritos",
      "icon": Icons.favorite,
      "onTap": (ctx) {},
    },
    {
      "title": "Configuración",
      "icon": Icons.settings,
      "onTap": (ctx) {},
    },
    {
      "title": "Cerrar Sesión",
      "icon": Icons.exit_to_app_rounded,
      "onTap": (ctx) {},
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = getUserOrLogOut(ref, context);
    return Center(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 64,
                backgroundColor: AppTheme.primaryColor,
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(60),
                    child: Image.asset('assets/images/default-avatar.jpg'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                user!.username,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -17, // Adjust this value to overlap the top container
                    left: 1,
                    right: 1,
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 6,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        ..._settings.map((setting) {
                          return Material(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(setting["title"] as String),
                                  leading: Icon(setting["icon"] as IconData),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                  onTap: () {
                                    (setting["onTap"] as void Function(BuildContext))(context);
                                  },
                                ),
                                Divider(
                                  height: 0,
                                  thickness: 1,
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              )
              // TextButton(
              //   onPressed: () async {
              //     await ref.watch(authRepositoryProvider).logOut();
              //   },
              //   child: Text("Logout"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
