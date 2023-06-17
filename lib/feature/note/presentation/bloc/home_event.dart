part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeInitScreen extends HomeEvent {}

final class HomeAddButtonPressed extends HomeEvent {}

final class HomeSnackbarDisplayed extends HomeEvent {}
