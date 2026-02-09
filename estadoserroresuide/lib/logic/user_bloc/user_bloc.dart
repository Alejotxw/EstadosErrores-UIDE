import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../data/models/user_model.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final Dio dio;
  UserCubit(this.dio) : super(UserLoading());

  Future<void> fetchUsers() async {
    emit(UserLoading());
    try {
      final response = await dio.get('/users');
      final List<dynamic> data = response.data;

      if (data.isEmpty) {
        emit(UserEmpty());
      } else {
        final users = data.map((e) => UserModel.fromJson(e)).toList();
        emit(UserSuccess(users));
      }
    } on DioException catch (e) {
      String msg = e.response?.statusCode == 401 
          ? "No autorizado (401)" 
          : "Error de servidor (500)";
      emit(UserError(msg));
    } catch (e) {
      emit(UserError("Error inesperado de conexión"));
    }
  }
}