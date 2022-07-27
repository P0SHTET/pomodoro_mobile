// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PomodoroDto _$PomodoroDtoFromJson(Map<String, dynamic> json) => PomodoroDto(
      json['title'] as String,
      json['restHours'] as int,
      json['restMinutes'] as int,
      json['workHours'] as int,
      json['workMinutes'] as int,
    )..id = json['id'] as String;

Map<String, dynamic> _$PomodoroDtoToJson(PomodoroDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'workHours': instance.workHours,
      'workMinutes': instance.workMinutes,
      'restHours': instance.restHours,
      'restMinutes': instance.restMinutes,
    };
