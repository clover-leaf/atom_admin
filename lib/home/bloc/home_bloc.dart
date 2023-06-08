import 'package:atom_admin/packages/user_repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._userRepository, {required String userId})
      : super(HomeState(userId: userId)) {
    on<DeleteDomain>(_onDeleteDomain);
    on<SaveDomain>(_onSaveDomain);
  }

  final UserRepository _userRepository;

  Stream<dynamic> get domain => _userRepository.domain(state.userId);

  Future<void> _onDeleteDomain(
      DeleteDomain event, Emitter<HomeState> emit) async {
    await _userRepository.deleteDomain(domainId: event.domainId);
  }

  Future<void> _onSaveDomain(SaveDomain event, Emitter<HomeState> emit) async {
    await _userRepository.saveDomain(
        domain: event.domain, userId: state.userId);
  }
}
