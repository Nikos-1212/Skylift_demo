part of 'get_user_bloc.dart';

sealed class GetUserEvent extends Equatable {
  const GetUserEvent();

  @override
  List<Object> get props => [];
}

class GetuserInitalevent extends GetUserEvent {
  const GetuserInitalevent();
  @override
  List<Object> get props => [];
}

class GetuserDeleteevent extends GetUserEvent {
  final int index;
  const GetuserDeleteevent(this.index);
  @override
  List<Object> get props => [index];
}

class GetuserUpdateevent extends GetUserEvent {
  final int index;
  final String name;
  final String email;
  const GetuserUpdateevent(this.index, this.name, this.email);
  @override
  List<Object> get props => [index, name, email];
}
