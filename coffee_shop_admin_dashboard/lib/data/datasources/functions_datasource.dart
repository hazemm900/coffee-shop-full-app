import 'package:cloud_functions/cloud_functions.dart';

abstract class FunctionsDataSource {
  Future<void> sendNotificationToAll({
    required String title,
    required String body,
  });
}

class FunctionsDataSourceImpl implements FunctionsDataSource {
  final FirebaseFunctions _functions;
  FunctionsDataSourceImpl(this._functions);

  @override
  Future<void> sendNotificationToAll({
    required String title,
    required String body,
  }) async {
    // احصل على الـ Function التي سنقوم بنشرها لاحقًا
    final callable = _functions.httpsCallable('sendNotificationToAllUsers');
    // قم باستدعائها وأرسل البيانات
    await callable.call<void>({'title': title, 'body': body});
  }
}
