import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserShimmer extends StatelessWidget {
  const UserShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListTile(
          leading: CircleAvatar(backgroundColor: Colors.white),
          title: Container(height: 10, width: 100, color: Colors.white),
          subtitle: Container(height: 10, width: double.infinity, color: Colors.white),
        ),
      ),
    );
  }
}