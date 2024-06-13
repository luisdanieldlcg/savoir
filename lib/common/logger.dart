import 'package:logger/logger.dart';

class AppLogger {
  static Logger getLogger(Type type) {
    return Logger(
      printer: AppLogPrinter(
        className: type.toString(),
      ),
      level: Level.info,
    );
  }
}

class AppLogPrinter extends LogPrinter {
  final String className;

  AppLogPrinter({
    required this.className,
  });

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.defaultLevelColors[event.level];
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level]!;
    final emojiOutput = emoji.replaceAll(' ', '');
    final message = event.message;
    final time = DateTime.now();
    return [
      color!(
            "[${time.hour}:${time.minute}:${time.second}] [$className/${event.level.name.toUpperCase()}]$emojiOutput ",
          ) +
          message,
    ];
  }
}
