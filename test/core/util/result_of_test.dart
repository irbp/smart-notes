import 'package:flutter_test/flutter_test.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/core/util/result_of.dart';

void main() {
  test(
    'given a function, return success if the execution does not throw an exception (resultOf)',
    () {
      final expected = Result.success('Test');

      final actual = resultOf(() => 'Test');

      expect(actual, equals(expected));
    },
  );

  test(
    'given a function, return failure if the execution throws an exception (resultOf)',
    () {
      final expected = Result.error(GenericError());

      final actual = resultOf(() => throw Exception());

      expect(actual, equals(expected));
    },
  );

  test(
    'given a function, return success if the execution does not throw an exception (asyncResultOf)',
    () async {
      final expected = Result.success('Test');

      final actual = await asyncResultOf(() async => 'Test');

      expect(actual, equals(expected));
    },
  );

  test(
    'given a function, return failure if the execution throws an exception (asyncResultOf)',
    () async {
      final expected = Result.error(GenericError());

      final actual = await asyncResultOf(() async => throw Exception());

      expect(actual, equals(expected));
    },
  );
}
