import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_state.dart';
import '../../data/models/user_model.dart';
import 'package:dio/dio.dart';

class UserCubit extends Cubit<UserState> {
  final Dio dio;
  UserCubit(this.dio) : super(UserLoading());

  Future<void> fetchUsers() async {
    // Si quieres que ni siquiera se vea el Shimmer, puedes comentar la línea de abajo, 
    // pero lo ideal es dejarla para que la app no se congele.
    emit(UserLoading()); 

    try {
      final response = await dio.get('/users');
      final List<dynamic> data = response.data;

      // Mapeo directo
      final users = data.map((e) => UserModel.fromJson(e)).toList();
      emit(UserSuccess(users)); 

    } catch (e) {
      // Incluso si hay un error real de internet, podrías forzar datos locales aquí
      // para que siempre sea "Success", pero lo normal es que si la URL está bien,
      // con el interceptor limpio ya veas el éxito.
      emit(UserError("Error inesperado")); 
    }
  }
}