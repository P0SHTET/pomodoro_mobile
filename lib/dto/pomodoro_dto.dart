import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'pomodoro_dto.g.dart';

@JsonSerializable()
class PomodoroDto {
  String id = const Uuid().v1();
  String title = 'New Pomodoro';
  int workHours = 0;
  int workMinutes = 25;
  int restHours = 0;
  int restMinutes = 5;

  PomodoroDto(this.title, this.restHours, this.restMinutes, this.workHours, this.workMinutes);

  factory PomodoroDto.fromJson(Map<String, dynamic> json) => _$PomodoroDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PomodoroDtoToJson(this);

  @override
  String toString() {
    return 'PomodoroDto{title: $title}';
  }
}
