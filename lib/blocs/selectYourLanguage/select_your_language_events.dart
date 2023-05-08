import 'package:equatable/equatable.dart';

abstract class LanguageEvent extends Equatable {}

class FetchLanguageEvent extends LanguageEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
