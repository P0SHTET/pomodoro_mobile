import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro_mobile/dto/pomodoro_dto.dart';
import 'package:pomodoro_mobile/main.dart';

final _nFormat = NumberFormat('00');
final _nStyle = TextStyle(
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
    final result = restClient?.getList();

    return FutureBuilder<List<PomodoroDto>>(
      future: result,
      builder: (BuildContext context, AsyncSnapshot<List<PomodoroDto>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final pom = snapshot.data![index];
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
                        Text(
                          ' - ',
                          style: _nStyle,
                        ),
                        Text(
                          '${_nFormat.format(pom.restHours)}:${_nFormat.format(pom.restMinutes)}',
                          style: _nStyle,
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
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
