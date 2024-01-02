part of 'get_user_bloc.dart';

sealed class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

final class GetUserInitial extends GetUserState {
  final UserModel userModel;
  const GetUserInitial({required this.userModel});
  @override
  List<Object> get props => [userModel];
}

final class GetUserLoading extends GetUserState {}

final class GetUserLoaded extends GetUserState {
  final UserModel userModel;

  const GetUserLoaded({required this.userModel});
  @override
  List<Object> get props => [userModel];
}

final class GetUserError extends GetUserState {
  final String error;

  const GetUserError({required this.error});
  @override
  List<Object> get props => [error];
}
