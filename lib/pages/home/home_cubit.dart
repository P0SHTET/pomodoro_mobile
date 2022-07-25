import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_mobile/dto/pomodoro_dto.dart';
import 'package:pomodoro_mobile/server/rest_client.dart';

class HomeState {
  final List<PomodoroDto> pomodoroList;

//<editor-fold desc="Data Methods">

  const HomeState({
    required this.pomodoroList,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HomeState &&
          runtimeType == other.runtimeType &&
          pomodoroList == other.pomodoroList);

  @override
  int get hashCode => pomodoroList.hashCode;

  @override
  String toString() {
    return 'HomeState{' + ' pomodoroList: $pomodoroList,' + '}';
  }

  HomeState copyWith({
    List<PomodoroDto>? pomodoroList,
  }) {
    return HomeState(
      pomodoroList: pomodoroList ?? this.pomodoroList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pomodoroList': this.pomodoroList,
    };
  }

  factory HomeState.fromMap(Map<String, dynamic> map) {
    return HomeState(
      pomodoroList: map['pomodoroList'] as List<PomodoroDto>,
    );
  }

//</editor-fold>
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
    final newState = state.copyWith(pomodoroList: pomodoroList);
    emit(newState);
  }

  void removePomodoro(String id) {
    var pomodoroList = state.pomodoroList;
    var removablePomodoro = pomodoroList.firstWhere((element) => element.title == id);
    pomodoroList.remove(removablePomodoro);
    final newState = state.copyWith(pomodoroList: pomodoroList);
    print(newState);
    emit(newState);
  }

  void addPomodoro() {
    var pomodoroList = state.pomodoroList;
    pomodoroList.add(PomodoroDto('New Pomodoro ${pomodoroList.length + 1}', 0, 5, 0, 25));
    final newState = state.copyWith(pomodoroList: pomodoroList);

    print(newState);

    emit(newState);
  }
}
