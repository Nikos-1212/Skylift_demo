import 'dart:async';

import 'package:demo/bloc/timer_bloc/cubit/timer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer page'),
      ),
      body: Column(
        children: [_body(), _buttons(context)],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: BlocConsumer<TimerCubit, TimerState>(
        listener: (context, state) {

          // TODO: implement listener
        },        
        builder: (context, state) {
          if (state is TimerInitial) {
            // final val = BlocProvider.of<TimerCubit>(context).;
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(
                    value: 1 - (state.timerModel.secondsRemaining / 60),
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
                ),
                Text(
                  '${state.timerModel.secondsRemaining}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                )
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buttons(BuildContext context) {
     print('Context: $context');
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () async{                   

    BlocProvider.of<TimerCubit>(context).startTimer();
                
              },
              child: const Text('Start')),
          ElevatedButton(
              onPressed: () async{
                
                BlocProvider.of<TimerCubit>(context).stopTimer.call();
              },
              child: const Text('Stop')),
          ElevatedButton(
              onPressed: () async{                
                BlocProvider.of<TimerCubit>(context).resumeTimer.call();
              },
              child: const Text('Resume')),
        ],
      ),
    );
  }
}
