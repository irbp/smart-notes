import 'package:flutter_test/flutter_test.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/core/error/domain_error.dart';
import 'package:smart_notes/core/presentation/ui_error/domain_error_mapper.dart';
import 'package:smart_notes/core/presentation/ui_error/error_mapper.dart';
import 'package:smart_notes/core/presentation/ui_error/error_strings.dart';

void main() {
  test(
    'given an domain error, map to the domain error text if domain error mapper is not null',
    () {
      const expected = 'Test error!';
      final errorMapper = ErrorMapper(
        domainErrorMapper: TestDomainErrorMapper(),
      );

      final actual = errorMapper.fromAppError(TestError());

      expect(actual, equals(expected));
    },
  );

  test(
    'given an domain error, map to generic error text if domain error mapper is null',
    () {
      const expected = ErrorStrings.genericError;
      final errorMapper = ErrorMapper(domainErrorMapper: null);

      final actual = errorMapper.fromAppError(TestError());

      expect(actual, equals(expected));
    },
  );

  test(
    'given any app error except domain error, map to generic error text',
    () {
      const expected = ErrorStrings.genericError;
      final errorMapper = ErrorMapper(
        domainErrorMapper: TestDomainErrorMapper(),
      );

      final actual = errorMapper.fromAppError(GenericError());

      expect(actual, equals(expected));
    },
  );
}

class TestError extends DomainError {}

class TestDomainErrorMapper implements DomainErrorMapper {
  @override
  String fromDomainError(DomainError domainError) {
    return 'Test error!';
  }
}
