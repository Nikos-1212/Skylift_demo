import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo/entity/timer_model.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerInitial(TimerModel(secondsRemaining: 60, timer: Timer(const Duration(seconds: 1),() {}))));

  Future<void> startTimer() async {
    if (state is TimerInitial) {
      TimerInitial currentState = state as TimerInitial;
      TimerModel updatedModel = currentState.timerModel.copyWith(secondsRemaining: 60, timer: Timer(const Duration(seconds: 1),() {}));
      emit(TimerInitial(updatedModel));

      updatedModel.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (updatedModel.secondsRemaining > 0) {
          updatedModel = updatedModel.copyWith(secondsRemaining: updatedModel.secondsRemaining - 1);
          emit(TimerInitial(updatedModel));
        } else {
          updatedModel = updatedModel.copyWith(secondsRemaining: 0);
          updatedModel.timer.cancel();
          emit(TimerInitial(updatedModel));
        }
      });
    }
  }
Future<void> stopTimer() async {
  if (state is TimerInitial) {
    TimerInitial currentState = state as TimerInitial;
    if (currentState.timerModel.timer.isActive) {

      TimerModel updatedModel = currentState.timerModel.copyWith(secondsRemaining: currentState.timerModel.secondsRemaining,);
          updatedModel.timer.cancel();
          emit(TimerInitial(updatedModel));      
      // emit(TimerInitial(updatedModel.copyWith(timer: null)));
    }
  }
}






  Future<void> resumeTimer() async {
    if (state is TimerInitial) {
      TimerInitial currentState = state as TimerInitial;
      TimerModel updatedModel = currentState.timerModel.copyWith(secondsRemaining: currentState.timerModel.secondsRemaining, timer: Timer(const Duration(seconds: 1),() {}));
      emit(TimerInitial(updatedModel));

      updatedModel.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (updatedModel.secondsRemaining > 0) {
          updatedModel = updatedModel.copyWith(secondsRemaining: updatedModel.secondsRemaining - 1);
          emit(TimerInitial(updatedModel));
        } else {
          updatedModel = updatedModel.copyWith(secondsRemaining: 0);
          updatedModel.timer.cancel();
          emit(TimerInitial(updatedModel));
        }
      });
    }
  }
}
