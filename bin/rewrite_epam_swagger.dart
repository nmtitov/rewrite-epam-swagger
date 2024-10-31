// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:args/args.dart';

// 🌎 Project imports:
import 'package:rewrite_epam_swagger/rewrite_epam_swagger.dart';

const path = 'path';

Future<void> main(List<String> arguments) async {
    exitCode = 0; // Presume success
    final parser = ArgParser();
    ArgResults argResults = parser.parse(arguments);
    final path = argResults.arguments.first;

    await processFile(path: path);
}
