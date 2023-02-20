part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeData extends HomeState {
  final Data data;
  const HomeData(this.data);
  @override
  List<Object> get props => [data];
}

class HomeUnauthenticated extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeError extends HomeState {
  @override
  List<Object> get props => [];
}
