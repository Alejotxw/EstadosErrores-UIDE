import '../../data/models/user_model.dart';

abstract class UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<UserModel> users;
  UserSuccess(this.users);
}

class UserEmpty extends UserState {}

class UserError extends UserState {
  final String errorMessage;
  UserError(this.errorMessage);
}