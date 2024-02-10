part of 'timer_cubit.dart';

sealed class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object> get props => [];
}

 class TimerInitial extends TimerState {
  final TimerModel timerModel;
  const TimerInitial(this.timerModel);

  @override
  List<Object> get props => [timerModel];
}
