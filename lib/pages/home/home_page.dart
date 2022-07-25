import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
          body: ListView.builder(
            itemCount: pomodoroList.length,
            itemBuilder: (context, index) {
              final pom = pomodoroList[index];
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${_nFormat.format(pom.workHours)}:${_nFormat.format(pom.workMinutes)}',
                          style: _nStyle,
                        ),
                        const Text(
                          ' - ',
                          style: _nStyle,
                        ),
                        Text(
                          '${_nFormat.format(pom.restHours)}:${_nFormat.format(pom.restMinutes)}',
                          style: _nStyle,
                        ),
                        ElevatedButton(
                          onPressed: () => cubit.removePomodoro(pom.title),
                          child: const Icon(Icons.delete_forever),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          pom.title,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: cubit.addPomodoro,
            child: const Icon(Icons.add_circle_outline),
          ),
        );
      },
    );
    ;
    // StreamBuilder<HomeState>(
    //   initialData: cubit.state,
    //   stream: cubit.stream,
    //   builder: (context, snapshot) {
    //     final pomodoroList = snapshot.requireData.pomodoroList;
    //     return Scaffold(
    //       body: ListView.builder(
    //         itemCount: pomodoroList.length,
    //         itemBuilder: (context, index) {
    //           final pom = pomodoroList[index];
    //           return Padding(
    //             padding: const EdgeInsets.all(15),
    //             child: Column(
    //               children: [
    //                 Row(
    //                   children: [
    //                     Text(
    //                       '${_nFormat.format(pom.workHours)}:${_nFormat.format(pom.workMinutes)}',
    //                       style: _nStyle,
    //                     ),
    //                     const Text(
    //                       ' - ',
    //                       style: _nStyle,
    //                     ),
    //                     Text(
    //                       '${_nFormat.format(pom.restHours)}:${_nFormat.format(pom.restMinutes)}',
    //                       style: _nStyle,
    //                     ),
    //                     ElevatedButton(
    //                       onPressed: () => cubit.removePomodoro(pom.title),
    //                       child: const Icon(Icons.delete_forever),
    //                     ),
    //                   ],
    //                 ),
    //                 Row(
    //                   children: [
    //                     Text(
    //                       pom.title,
    //                       style: const TextStyle(fontSize: 20),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           );
    //         },
    //       ),
    //       floatingActionButton: FloatingActionButton(
    //         onPressed: cubit.addPomodoro,
    //         child: const Icon(Icons.add_circle_outline),
    //       ),
    //     );
    //   },
    // );
  }
}
