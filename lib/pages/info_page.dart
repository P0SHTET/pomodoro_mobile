import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoPage extends StatelessWidget {
  static const description =
      '«Метод помидора» — техника управления временем. Методика предполагает увеличение эффективности работы при меньших временных затратах за счёт глубокой концентрации и коротких перерывов.';

  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.5,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/tomato.png',
              height: 200,
              width: 200,
              color: Colors.deepPurple,
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Данное приложение созданно с помощью Flutter. Ознакомиться '
                      'с исходным кодом можно в ',
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      launchUrlString(
                        'https://github.com/P0SHTET/pomodoro_mobile',
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    onLongPress: () {
                      Clipboard.setData(
                        const ClipboardData(text: 'https://github.com/P0SHTET/pomodoro_mobile'),
                      );
                      Fluttertoast.showToast(msg: 'Ссылка успешно скопирована!');
                    },
                    child: const Text(
                      'репозитории на GitHub',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurpleAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
