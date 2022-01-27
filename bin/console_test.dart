import 'package:console_test/simple_worker_isolate.dart';

Future<void> main(List<String> arguments) async {
  final result = await parseInBackground();
  print(result.length);
}
