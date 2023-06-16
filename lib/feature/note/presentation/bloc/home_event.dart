part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class InitScreen extends HomeEvent {}

final class ClickOnAddButton extends HomeEvent {}

final class SnackbarDisplayed extends HomeEvent {}
