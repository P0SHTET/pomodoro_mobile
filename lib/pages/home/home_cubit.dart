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

  HomeCubit() : super(HomeState(pomodoroList: [])) {
    _initialize();
  }

  void _initialize() async {
    final pomodoroList = await _pomodoroClient.getList();
    final newState = HomeState(pomodoroList: pomodoroList);
    emit(newState);
  }

  void removePomodoro(String id) async {
    var pomodoroList = state.pomodoroList;
    var removablePomodoro = pomodoroList.firstWhere((element) => element.title == id);
    pomodoroList.remove(removablePomodoro);
    final newState = HomeState(pomodoroList: pomodoroList);
    emit(newState);
  }

  void addPomodoro() async {
    var pomodoroList = state.pomodoroList;
    pomodoroList.add(PomodoroDto('New Pomodoro ${pomodoroList.length + 1}', 0, 5, 0, 25));

    final newState = HomeState(pomodoroList: pomodoroList);
    emit(newState);
  }
}
