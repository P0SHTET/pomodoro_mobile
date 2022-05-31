import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoPage extends StatelessWidget {
  static const description =
      '«Метод помидора» — техника управления временем. Методика предполагает увеличение эффективности работы при меньших временных затратах за счёт глубокой концентрации и коротких перерывов. \n';

  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(
                    text:
                        'Данное приложение созданно с помощью Flutter. Ознакомиться с исходным кодом можно в '),
                TextSpan(
                  text: 'репозитории на GitHub',
                  style: const TextStyle(
                    color: Colors.deepPurpleAccent,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrlString('https://github.com/P0SHTET/pomodoro_mobile'),
                )
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
