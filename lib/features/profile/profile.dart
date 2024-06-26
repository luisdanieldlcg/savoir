import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickalert/quickalert.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/user_avatar.dart';
import 'package:savoir/features/auth/repository/auth_repository.dart';
import 'package:savoir/router.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  static final _settings = [
    {
      "title": "Datos Personales",
      "icon": Icons.person,
      "route": AppRouter.personalDetails,
    },
    {
      "title": "Métodos de pago",
      "icon": Icons.credit_card,
      "route": AppRouter.home,
    },
    {
      "title": "Preferencias de comida",
      "icon": Icons.fastfood,
      "route": AppRouter.home,
    },
    {
      "title": "Ver estadísticas",
      "icon": Icons.bar_chart,
      "route": AppRouter.home,
    },
    {
      "title": "Favoritos",
      "icon": Icons.favorite,
      "route": AppRouter.home,
    },
    {
      "title": "Configuración",
      "icon": Icons.settings,
      "route": AppRouter.home,
    },
    {
      "title": "Cerrar Sesión",
      "icon": Icons.exit_to_app_rounded,
      "route": AppRouter.welcome,
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = getUserOrLogOut(ref, context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              UserAvatar(imageSrc: user!.profilePicture),
              const SizedBox(height: 20),
              Text(
                user.username,
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
                                    if (setting["route"] == AppRouter.welcome) {
                                      QuickAlert.show(
                                        context: context,
                                        animType: QuickAlertAnimType.slideInUp,
                                        type: QuickAlertType.confirm,
                                        title: "Cerrar Sesión",
                                        text: "¿Estás seguro de que deseas cerrar sesión?",
                                        confirmBtnColor: AppTheme.primaryColor,
                                        onConfirmBtnTap: () {
                                          ref.watch(authRepositoryProvider).logOut();
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            setting["route"] as String,
                                            (route) => false,
                                          );
                                        },
                                        onCancelBtnTap: () => Navigator.pop(context),
                                        cancelBtnTextStyle:
                                            TextStyle(color: Colors.black, fontSize: 18),
                                        cancelBtnText: "Cancelar",
                                        confirmBtnText: "Continuar",
                                      );
                                    } else {
                                      Navigator.pushNamed(
                                        context,
                                        setting["route"] as String,
                                      );
                                    }
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
            ],
          ),
        ),
      ),
    );
  }
}
