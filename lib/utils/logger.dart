import 'package:logger/logger.dart';

Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 75,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);
