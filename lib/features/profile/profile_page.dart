import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/features/auth/repository/auth_repository.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = getUserOrLogOut(ref, context);
    return Center(
      child: SafeArea(
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
            const SizedBox(height: 14),
            Text(
              user!.username,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              alignment: Alignment.center, // FIXME: does it work for you?
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Text("Datos Personales"),
                    leading: Icon(Icons.person),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 18,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Cerrar Sesión"),
                    leading: Icon(Icons.exit_to_app_rounded),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                await ref.watch(authRepositoryProvider).logOut();
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
