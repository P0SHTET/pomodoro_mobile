import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_mobile/dto/pomodoro_dto.dart';
import 'package:pomodoro_mobile/main.dart';

class HomeState extends Equatable {
  final List<PomodoroDto> pomodoroList;

  const HomeState({
    required this.pomodoroList,
  });

  HomeState copyWith({
    List<PomodoroDto>? pomodoroList,
  }) {
    return HomeState(
      pomodoroList: pomodoroList ?? this.pomodoroList,
    );
  }

  @override
  List<Object?> get props => [pomodoroList];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState(pomodoroList: []));

  Future<void> updatePomodoros() async {
    final pomodoroList = await restClient!.getList();
    final newState = HomeState(pomodoroList: pomodoroList);
    emit(newState);
  }

  void addPomodoro() async {
    var newPomodoro = PomodoroDto('New Pomodoro', 0, 5, 0, 25);
    await restClient!.addPomodoro(newPomodoro);

    await updatePomodoros();
  }

  void removePomodoro(String id) async {
    await restClient!.removePomodoro(id);

    await updatePomodoros();
  }

  void updatePomodoro(PomodoroDto dto) async {
    await restClient!.updatePomodoro(dto.id, dto);

    await updatePomodoros();
  }
}
