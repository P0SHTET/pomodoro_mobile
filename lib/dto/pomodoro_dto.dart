import 'package:json_annotation/json_annotation.dart';

part 'pomodoro_dto.g.dart';

@JsonSerializable()
class PomodoroDto {
  String title = 'New Pomodoro';
  int workHours = 0;
  int workMinutes = 25;
  int restHours = 0;
  int restMinutes = 5;

  PomodoroDto(this.title, this.restHours, this.restMinutes, this.workHours, this.workMinutes);

  factory PomodoroDto.fromJson(Map<String, dynamic> json) => _$PomodoroDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PomodoroDtoToJson(this);
}
