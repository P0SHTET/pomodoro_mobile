import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro_mobile/dto/pomodoro_dto.dart';
import 'package:pomodoro_mobile/pages/home/home_cubit.dart';

final _nFormat = NumberFormat('00');
const _nStyle = TextStyle(
  fontSize: 48,
);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: cubit,
      builder: (context, snapshot) {
        final pomodoroList = snapshot.pomodoroList;
        return Scaffold(
          body: ListView.separated(
            itemCount: pomodoroList.length,
            itemBuilder: (context, index) {
              final pom = pomodoroList[index];
              return PomodoroTile(
                dto: pom,
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: cubit.addPomodoro,
            child: const Icon(Icons.add_circle_outline),
          ),
        );
      },
    );
  }
}

class PomodoroTile extends StatelessWidget {
  PomodoroDto _dto;

  PomodoroTile({
    Key? key,
    required PomodoroDto dto,
  })  : _dto = dto,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${_nFormat.format(_dto.workHours)}:${_nFormat.format(_dto.workMinutes)}',
                    style: _nStyle,
                  ),
                  const Text(
                    ' - ',
                    style: _nStyle,
                  ),
                  Text(
                    '${_nFormat.format(_dto.restHours)}:${_nFormat.format(_dto.restMinutes)}',
                    style: _nStyle,
                  ),
                ],
              ),
              const IconButton(
                //TODO: implements start pomodoro
                onPressed: null,
                icon: Icon(
                  Icons.play_circle_outline,
                  size: 48,
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                _dto.title,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
