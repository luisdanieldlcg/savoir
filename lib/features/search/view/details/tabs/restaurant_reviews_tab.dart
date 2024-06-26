import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/util.dart';
import 'package:savoir/common/widgets/buttons.dart';
import 'package:savoir/common/widgets/shimmers.dart';
import 'package:savoir/common/widgets/user_avatar.dart';
import 'package:savoir/features/auth/model/user_model.dart';
import 'package:savoir/features/search/controller/restaurant_search_controller.dart';
import 'package:savoir/features/search/model/restaurant_details.dart';
import 'package:savoir/features/search/view/details/restaurant_details_view.dart';

class RestaurantReviewsTab extends ConsumerStatefulWidget {
  final RestaurantDetails details;
  final String placeId;

  const RestaurantReviewsTab({
    super.key,
    required this.details,
    required this.placeId,
  });

  @override
  ConsumerState<RestaurantReviewsTab> createState() => _RestaurantReviewsTabState();
}

class _RestaurantReviewsTabState extends ConsumerState<RestaurantReviewsTab> {
  int _rating = 1;
  final _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = getUserOrLogOut(ref, context)!;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => openModal(context, user),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      body: ListView.builder(
          itemCount: widget.details.reviews.length,
          itemBuilder: (context, index) {
            final review = widget.details.reviews[index];
            return CachedNetworkImage(
              imageUrl: review.profilePhotoUrl,
              imageBuilder: (context, imageProvider) {
                return Column(
                  children: [
                    const SizedBox(height: 16),
                    ListTile(
                      isThreeLine: true,
                      leading: UserAvatar(
                        imageSrc: review.profilePhotoUrl,
                        size: 55,
                      ),
                      title: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 155,
                                child: Text(
                                  review.authorName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Spacer(),
                              Text(
                                review.relativeTimeDescription,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppTheme.primaryColor,
                                size: 16,
                              ),
                              Text(
                                review.rating.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.text,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(review.authorName),
                                    content: Text(review.text),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cerrar"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Ver más",
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.black12,
                    ),
                  ],
                );
              },
              placeholder: (context, url) => ShimmerCompact(index: index),
            );
          }),
      // body: ListView.builder(
      //   itemCount: widget.details.reviews.length,
      //   itemBuilder: (context, index) {
      //     final review = widget.details.reviews[index];
      //     return Column(
      //       children: [
      //         ListTile(
      //           isThreeLine: true,
      //           leading: CircleAvatar(
      //             backgroundImage: NetworkImage(review.profilePhotoUrl),
      //           ),
      //           title: Column(
      //             children: [
      //               Row(
      //                 children: [
      //                   SizedBox(
      //                     width: 170,
      //                     child: Text(
      //                       review.authorName,
      //                       style: const TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                       overflow: TextOverflow.ellipsis,
      //                     ),
      //                   ),
      //                   Spacer(),
      //                   Text(
      //                     review.relativeTimeDescription,
      //                     style: const TextStyle(
      //                       fontSize: 14,
      //                       color: Colors.black54,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               Row(
      //                 children: [
      //                   Icon(
      //                     Icons.star,
      //                     color: AppTheme.primaryColor,
      //                     size: 16,
      //                   ),
      //                   Text(
      //                     review.rating.toString(),
      //                     style: const TextStyle(
      //                       fontSize: 14,
      //                       color: Colors.black54,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //           subtitle: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 review.text,
      //                 style: const TextStyle(
      //                   fontSize: 14,
      //                   color: Colors.black54,
      //                 ),
      //                 maxLines: 2,
      //                 overflow: TextOverflow.ellipsis,
      //               ),
      //               const SizedBox(height: 5),
      //               GestureDetector(
      //                 onTap: () {
      //                   showDialog(
      //                     context: context,
      //                     builder: (context) {
      //                       return AlertDialog(
      //                         title: Text(review.authorName),
      //                         content: Text(review.text),
      //                         actions: [
      //                           TextButton(
      //                             onPressed: () {
      //                               Navigator.pop(context);
      //                             },
      //                             child: Text("Cerrar"),
      //                           ),
      //                         ],
      //                       );
      //                     },
      //                   );
      //                 },
      //                 child: Text(
      //                   "Ver más",
      //                   style: const TextStyle(
      //                     fontSize: 14,
      //                     color: AppTheme.primaryColor,
      //                   ),
      //                 ),
      //               ),
      //               const SizedBox(height: 5),
      //             ],
      //           ),
      //         ),
      //         // Divider
      //         const Divider(
      //           height: 1,
      //           thickness: 1,
      //           color: Colors.black12,
      //         ),
      //         const SizedBox(height: 10),
      //       ],
      //     );
      //   },
      // ),
    );
  }

  void openModal(BuildContext context, UserModel user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const Text(
                "Agregar reseña",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: ListTile(
                  leading: UserAvatar(
                    imageSrc: user.profilePicture,
                    size: 55,
                  ),
                  title: Text("${user.firstName} ${user.lastName}"),
                  subtitle: Text(
                    "Se mostrará públicamente en la app",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 1; i <= 5; i++)
                        IconButton(
                          icon: Icon(
                            i <= _rating ? Icons.star : Icons.star_border,
                            color: AppTheme.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _rating = i;
                            });
                          },
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _reviewController,
                decoration: InputDecoration(
                  hintText: "Comparte detalles sobre tu experiencia en este lugar",
                  hintStyle: TextStyle(color: Colors.black54, fontStyle: FontStyle.italic),
                ),
                maxLines: 10,
              ),
              const SizedBox(height: 80),
              Row(
                // cancel and publish buttons
                children: [
                  Expanded(
                    child: SecondaryButton(
                      text: "Cancelar",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PrimaryButton(
                      text: "Publicar",
                      rightIcon: Icons.send,
                      onPressed: () {
                        if (_reviewController.text.isEmpty) {
                          return;
                        }

                        ref.read(restaurantSearchProvider.notifier).publishComment(
                              review: _reviewController.text,
                              rating: _rating,
                              authorName: user.username,
                              profileImage: user.profilePicture,
                              placeId: widget.placeId,
                            );
                        ref.invalidate(restaurantDetailsProvider(widget.placeId));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
