import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

Future<List<dynamic>> parseInBackground() async {
  final time = Stopwatch()..start();
  final p = ReceivePort();
  await Isolate.spawn(_readAndParseJson, p.sendPort);
  time.stop();
  print('data parsing took -- ${time.elapsedMilliseconds} milliseconds');
  return await p.first;
}

Future _readAndParseJson(SendPort p) async {
  final fileData = await File('lib/data/json/large.json').readAsString();
  final jsonData = jsonDecode(fileData);
  Isolate.exit(p, jsonData);
}
