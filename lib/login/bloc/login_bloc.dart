import 'package:atom_admin/packages/user_repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._userRepository) : super(const LoginState()) {
    on<Submitted>(_onLogin);
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }

  final UserRepository _userRepository;

  void _onUsernameChanged(
    UsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(username: event.username));
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLogin(
    Submitted event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(status: LoginStatus.waiting));
      final res = await _userRepository.loginAdmin(
          username: state.username, password: state.password);
      emit(
        state.copyWith(
          status: LoginStatus.success,
          userId: res['id'],
        ),
      );
    } catch (error) {
      final err = error.toString().split(':').last.trim();
      emit(state.copyWith(status: LoginStatus.failure, error: () => err));
    }
  }
}
