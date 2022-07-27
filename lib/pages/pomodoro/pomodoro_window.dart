import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pomodoro_mobile/dto/pomodoro_dto.dart';

class PomodoroWindow extends StatelessWidget {
  final PomodoroDto _pomodoroDto;
  final ValueSetter<PomodoroDto> _pomodoroChanged;

  const PomodoroWindow({
    Key? key,
    required PomodoroDto pomodoroDto,
    required ValueSetter<PomodoroDto> pomodoroChanged,
  })  : _pomodoroDto = pomodoroDto,
        _pomodoroChanged = pomodoroChanged,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Changing the Pomodoro'),
        actions: [
          IconButton(
            onPressed: () {
              _pomodoroChanged(_pomodoroDto);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.done,
              size: 36,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.clear,
            size: 36,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(
                        fontSize: 36,
                      ),
                    ),
                    textAlign: TextAlign.right,
                    controller: TextEditingController(
                      text: _pomodoroDto.title,
                    ),
                    onChanged: (value) => _pomodoroDto.title = value,
                    onSubmitted: (value) => _pomodoroDto.title = value,
                  ),
                ),
              ],
            ),
            Divider(
              height: 40,
              thickness: 0,
              color: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Work Time',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
            TimePicker(
              hours: _pomodoroDto.workHours,
              minutes: _pomodoroDto.workMinutes,
              hourChanged: (value) {
                _pomodoroDto.workHours = value;
              },
              minutesChanged: (value) {
                _pomodoroDto.workMinutes = value;
              },
            ),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Rest Time',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
            TimePicker(
              hours: _pomodoroDto.restHours,
              minutes: _pomodoroDto.restMinutes,
              hourChanged: (value) {
                _pomodoroDto.restHours = value;
              },
              minutesChanged: (value) {
                _pomodoroDto.restMinutes = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TimePicker extends StatefulWidget {
  int currentHours;
  int currentMinutes;
  final ValueSetter<int> hourChanged;
  final ValueSetter<int> minutesChanged;

  TimePicker({
    required int hours,
    required int minutes,
    required ValueSetter<int> hourChanged,
    required ValueSetter<int> minutesChanged,
  })  : currentHours = hours,
        currentMinutes = minutes,
        hourChanged = hourChanged,
        minutesChanged = minutesChanged;

  @override
  TimePickerState createState() => TimePickerState(
        hours: currentHours,
        minutes: currentMinutes,
        hourChanged: hourChanged,
        minutesChanged: minutesChanged,
      );
}

class TimePickerState extends State<TimePicker> {
  int currentHours;
  int currentMinutes;
  final ValueSetter<int> hourChanged;
  final ValueSetter<int> minutesChanged;

  TimePickerState({
    required int hours,
    required int minutes,
    required ValueSetter<int> hourChanged,
    required ValueSetter<int> minutesChanged,
  })  : currentHours = hours,
        currentMinutes = minutes,
        hourChanged = hourChanged,
        minutesChanged = minutesChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberPicker(
          minValue: 0,
          maxValue: 23,
          value: currentHours,
          onChanged: (value) {
            setState(() => currentHours = value);
            hourChanged(value);
          },
          zeroPad: true,
          infiniteLoop: true,
        ),
        const Text(':'),
        NumberPicker(
          minValue: 0,
          maxValue: 59,
          value: currentMinutes,
          onChanged: (value) {
            setState(() => currentMinutes = value);
            minutesChanged(value);
          },
          zeroPad: true,
          infiniteLoop: true,
        ),
      ],
    );
  }
}
