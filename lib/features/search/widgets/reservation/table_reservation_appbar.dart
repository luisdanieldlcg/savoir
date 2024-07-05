// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:savoir/common/theme.dart';
import 'package:savoir/features/auth/model/favorite_model.dart';

class TableReservationAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final RestaurantSummary summary;
  const TableReservationAppBar({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 106,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(AppTheme.primaryColor),
          backgroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: CachedNetworkImage(
        imageUrl: summary.photo,
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Container(
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(144);
}
