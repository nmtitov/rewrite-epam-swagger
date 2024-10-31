// 🎯 Dart imports:
import 'dart:convert';
import 'dart:io';

Future<void> processFile({required String? path}) async {
    if (path == null) {
        print("Error: please provide path to json schema file!");
        exit(-1);
    }
    final file = File(path);
    if (!file.existsSync()) {
        print("Error: file at provided path does not exist!");
        exit(-1);
    }

    final String jsonString = await file.readAsString();
    final jsonObject = await json.decode(jsonString);

    final jsonSchemas = jsonObject["components"]["schemas"];

    jsonSchemas.forEach((key, value) {
        var required = <String>[];

        final properties = value["properties"];
        if (properties != null) {
            properties.forEach((kkey, vvalue) {
                const nullable = "nullable";
                final nullableValue = vvalue[nullable];

                if (nullableValue != null && nullableValue == true) {
                    // print("THIS IS NULLABLE!!!");
                } else {
                    // print("REQUIRED!!!");
                    required.add(kkey);
                }
            });
        }

        if (required.isNotEmpty) {
            value["required"] = required;
        }
    });

    // print modified schema
    // prettyPrintJSON(jsonObject);

    final newString = prettyPrintedJSONString(jsonObject);
    await file.writeAsString(newString);

    exit(0);
}

String prettyPrintedJSONString(dynamic json) {
    var spaces = ' ' * 2;
    var encoder = JsonEncoder.withIndent(spaces);
    final string = encoder.convert(json);
    return string;
}

void prettyPrintJSON(dynamic json) {
    final string = prettyPrintedJSONString(json);
    print(string);
}
