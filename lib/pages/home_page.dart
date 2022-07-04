import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_mobile/dto/pomodoro_dto.dart';

import '../main.dart';

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
              final pomodoros = snapshot.data;
              return ListTile(
                title: Text(pomodoros![index].title),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
