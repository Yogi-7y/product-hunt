import 'package:logger/logger.dart';

class CustomLogPrinter extends LogPrinter {
  final String className;

  CustomLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];

    final emoji = PrettyPrinter.levelEmojis[event.level];

    return [color!('$emoji: ($className): ${event.message}')];
  }
}

Logger getLogger(String className) => Logger(
      printer: CustomLogPrinter(className),
    );
