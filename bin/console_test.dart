import 'package:console_test/hand_shake_isolates.dart';
import 'package:console_test/simple_worker_isolate.dart';

Future<void> main(List<String> arguments) async {
  parseInBackground().then((value) => print(value.length));
  handShakeIsolates();
}
