import 'package:flutter/material.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/features/search/model/restaurant_details.dart';

class RestaurantReviewsTab extends StatelessWidget {
  final RestaurantDetails details;

  const RestaurantReviewsTab({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: ListView.builder(
        itemCount: details.reviews.length,
        itemBuilder: (context, index) {
          final review = details.reviews[index];
          return Column(
            children: [
              ListTile(
                isThreeLine: true,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(review.profilePhotoUrl),
                ),
                title: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 170,
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
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              // Divider
              const Divider(
                height: 1,
                thickness: 1,
                color: Colors.black12,
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
