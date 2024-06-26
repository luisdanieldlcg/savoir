import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCompact extends StatelessWidget {
  final int index;
  const ShimmerCompact({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            isThreeLine: true,
            leading: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
            ),
            title: Container(
              width: 100,
              height: 10,
              color: Colors.grey[300],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Container(
                  width: index.isEven ? 200 : 150,
                  height: 10,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 6),
                Container(
                  width: index.isEven ? 150 : 200,
                  height: 10,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.black.withOpacity(0.1),
          height: 10,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}

class ShimmerList extends StatelessWidget {
  final int itemCount;
  const ShimmerList({
    super.key,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // text
              Container(
                width: double.infinity,
                height: 20,
                margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // text
              Container(
                width: double.infinity,
                height: 20,
                margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
