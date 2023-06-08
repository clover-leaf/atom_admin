part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({required this.userId});

  final String userId;

  @override
  List<Object> get props => [userId];

  HomeState copyWith({
    String? userId,
  }) {
    return HomeState(
      userId: userId ?? this.userId,
    );
  }
}
