part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class DeleteDomain extends HomeEvent {
  const DeleteDomain(this.domainId);

  final String domainId;

  @override
  List<Object> get props => [domainId];
}

class SaveDomain extends HomeEvent {
  const SaveDomain(this.domain);

  final String domain;

  @override
  List<Object> get props => [domain];
}
