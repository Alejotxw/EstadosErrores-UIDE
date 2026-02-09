import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/dio_client.dart';
import 'logic/user_bloc/user_bloc.dart';
import 'ui/screens/user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => UserCubit(DioClient.instance)..fetchUsers(),
        child: const UserScreen(),
      ),
    );
  }
}