import 'package:smart_notes/core/error/domain_error.dart';

abstract class DomainErrorMapper<E extends DomainError> {
  String fromDomainError(E error);
}
