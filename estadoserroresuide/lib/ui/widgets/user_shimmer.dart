import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserShimmer extends StatelessWidget {
  const UserShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8, // Mostramos suficientes elementos para llenar la pantalla
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Card(
              elevation: 1,
              child: ListTile(
                leading: const CircleAvatar(backgroundColor: Colors.white),
                title: Container(
                  height: 15,
                  width: 150,
                  color: Colors.white,
                ),
                subtitle: Container(
                  height: 10,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 5),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}