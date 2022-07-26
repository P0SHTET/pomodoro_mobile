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
                cubit: cubit,
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
  final PomodoroDto _dto;
  final HomeCubit _cubit;

  const PomodoroTile({
    Key? key,
    required PomodoroDto dto,
    required HomeCubit cubit,
  })  : _dto = dto,
        _cubit = cubit,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
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
      ),
      onLongPress: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Сonfirm the action'),
          content: const Text('Are you really going to delete this Pomodoro?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _cubit.removePomodoro(_dto.id);
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
