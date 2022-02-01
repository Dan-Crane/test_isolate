import 'dart:async';
import 'dart:isolate';

Future<void> handShakeIsolates() async {
  print('handShakeIsolates run');
  final port = ReceivePort();

  final secondIsolateInstance = await Isolate.spawn(
    secondIsolate,
    port.sendPort,
  );

  final streamOfMsg = port.asBroadcastStream();

  final timer = await streamOfMsg.first as SendPort;
  timer.send('start');

  var count = 0;
  streamOfMsg.listen(
    (e) {
      count++;
      if (count >= 10) {
        secondIsolateInstance.kill();
        Isolate.exit();
      } else {
        print(e);
      }
    },
  );
}

Future<void> secondIsolate(SendPort sendPort) async {
  print('create secondIsolate');
  final port = ReceivePort();

  sendPort.send(port.sendPort);

  await port.firstWhere((e) => e == 'start');

  Timer.periodic(const Duration(seconds: 1), (time) {
    sendPort.send(DateTime.now());
  });
}
