// To parse this JSON data, do
//
//     final TimerModel = TimerModelFromMap(jsonString);

import 'dart:async';

import 'package:meta/meta.dart';
import 'dart:convert';

TimerModel TimerModelFromMap(String str) => TimerModel.fromMap(json.decode(str));

String TimerModelToMap(TimerModel data) => json.encode(data.toMap());

class TimerModel {
    final int secondsRemaining;
     Timer timer;

    TimerModel({
        required this.secondsRemaining,
        required this.timer
    });

    TimerModel copyWith({
        int? secondsRemaining,
        Timer? timer 
    }) => 
        TimerModel(
            secondsRemaining: secondsRemaining ?? this.secondsRemaining,
            timer: timer ?? this.timer
        );

    factory TimerModel.fromMap(Map<String, dynamic> json) => TimerModel(
        secondsRemaining: json["secondsRemaining"],
        timer: json["timer"]
    );

    Map<String, dynamic> toMap() => {
        "secondsRemaining": secondsRemaining,
        "timer":timer
    };
}
