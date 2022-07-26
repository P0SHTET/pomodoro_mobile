import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_mobile/dto/pomodoro_dto.dart';
import 'package:pomodoro_mobile/server/rest_client.dart';

class HomeState extends Equatable {
  final List<PomodoroDto> pomodoroList;

  @override
  List<Object?> get props => [pomodoroList];

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
}

class HomeCubit extends Cubit<HomeState> {
  final _pomodoroClient = RestClient(
    Dio()..options.baseUrl = 'http://10.0.2.2:3000/',
  );

  HomeCubit() : super(const HomeState(pomodoroList: [])) {
    _initialize();
  }

  void _initialize() async {
    final pomodoroList = await _pomodoroClient.getList();
    final newState = HomeState(pomodoroList: pomodoroList);
    emit(newState);
  }

  void addPomodoro() async {
    var newPomodoro = PomodoroDto('New Pomodoro', 0, 5, 0, 25);
    await _pomodoroClient.addPomodoro(newPomodoro);
    final pomodoroList = await _pomodoroClient.getList();
    final newState = HomeState(pomodoroList: pomodoroList);
    emit(newState);
  }

  void removePomodoro(String id) async {
    await _pomodoroClient.removePomodoro(id);
    final pomodoroList = await _pomodoroClient.getList();
    final newState = HomeState(pomodoroList: pomodoroList);
    emit(newState);
  }
}
