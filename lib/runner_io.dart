import 'package:catty/runner_shared.dart';
import 'package:catty/src/feature/initialization/model/initialization_hook.dart';

// I\O runner
Future<void> run() async {
  // there could be some I\O specific initialization here
  sharedRun(
    InitializationHook.setup(),
  );
}
