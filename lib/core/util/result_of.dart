import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';

Result<T, AppError> resultOf<T>(T Function() func) {
  try {
    return Result.success(func());
  } catch (e) {
    return Result.error(GenericError());
  }
}

Future<Result<T, AppError>> asyncResultOf<T>(Future<T> Function() func) async {
  try {
    return Result.success(await func());
  } catch (e) {
    return Result.error(GenericError());
  }
}
