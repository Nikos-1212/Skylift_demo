import 'dart:async';
import 'package:demo/entity/user_model.dart';
import 'package:demo/repository/api_services.dart';
import 'package:demo/repository/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends HydratedBloc<GetUserEvent, GetUserState> {
  GetUserBloc() : super(GetUserInitial(userModel: UserModel())) {
    on<GetuserInitalevent>(getUserEvent);
    on<GetuserDeleteevent>(getuserDeleteevent);
    on<GetuserUpdateevent>(getuserUpdateevent);
  }

  FutureOr<void> getUserEvent(
      GetUserEvent event, Emitter<GetUserState> emit) async {
    if (state is GetUserInitial) {
      // fromJson(json)
      final currentINitState = state as GetUserInitial;
      if (currentINitState.userModel.records != null && currentINitState.userModel.records!.isNotEmpty) {
        emit(GetUserLoaded(userModel: currentINitState.userModel));
      } else {
        emit(GetUserLoading());
        try {
          final res = await ApiService().getUserList();
          emit(GetUserLoaded(userModel: res));
        } catch (e) {
          emit(GetUserError(error: e.toString()));
        }
      }
    }
  }

  FutureOr<void> getuserDeleteevent(
      GetuserDeleteevent event, Emitter<GetUserState> emit) async{
    if (state is GetUserLoaded) {
      final currentState = state as GetUserLoaded;
      final updatedRecords =
          List<Record>.from(currentState.userModel.records ?? []);
      updatedRecords.removeAt(event.index);
      // Create a new instance of UserModel with updated records
      final updatedUserModel =currentState.userModel.copyWith(records: updatedRecords);
      toJson(GetUserLoaded(userModel: updatedUserModel));
      emit(GetUserLoaded(userModel: updatedUserModel));
      if(updatedUserModel.records!.isEmpty)
      {
        try {
          emit(GetUserInitial(userModel: UserModel()));
          await getUserEvent(event, emit);          
        } catch (e) {
          await getUserEvent(event, emit);          
          print(e.toString());
        }
      }
    }
  }

  @override
  Map<String, dynamic> toJson(GetUserState state) {
    if (state is GetUserLoaded) {
      final modelJson = state.userModel.toMap();
      return {'userModel': modelJson}; ////
    }
    return {};
  }

  @override
  GetUserState? fromJson(Map<String, dynamic> json) {
    try {
      return GetUserInitial(
          userModel:
              UserModel.fromMap(json['userModel'] as Map<String, dynamic>));
    } catch (_) {
      return null;
    }
    // throw UnimplementedError();
  }

  @override
  Future<void> close() {
    // Ensuring that the bloc is closed properly
    return super.close();
  }

  FutureOr<void> getuserUpdateevent(
      GetuserUpdateevent event, Emitter<GetUserState> emit) {
    try {
      if (state is GetUserLoaded) {
        final currentState = state as GetUserLoaded;
        final updatedRecords =
            List<Record>.from(currentState.userModel.records ?? []);
        if (event.index >= 0 && event.index < updatedRecords.length) {
          // Assign the updated record back to the list
          updatedRecords[event.index] = updatedRecords[event.index]
              .copyWith(name: event.name, email: event.email);
          // Create a new instance of UserModel with updated records
          final updatedUserModel =
              currentState.userModel.copyWith(records: updatedRecords);
          toJson(GetUserLoaded(userModel: updatedUserModel));
          // Emit the updated state
          emit(GetUserLoaded(userModel: updatedUserModel));
        } else {}
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
