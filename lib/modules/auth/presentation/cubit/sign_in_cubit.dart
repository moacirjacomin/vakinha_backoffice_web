import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/shared_navigator.dart';
import '../../auth_navigator.dart';
import '../../domain/usecases/sign_in_usecase.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SharedNavigator sharedNavigator;
  final SignInUsecase signInUsecase;
  final AuthNavigator navigator;

  SignInCubit({
    required this.sharedNavigator,
    required this.signInUsecase,
    required this.navigator,
  }) : super(const SignInState());

  void onSignUpClicked() {
    // navigator.openSignUpPage();
  }

  Future<void> onSignInClicked({required String email, required String password}) async {
    print('onSignInClicked');
    emit(state.copyWith(status: Status.loading));
    
    final result = await signInUsecase(SignInParams(
      email: email,
      password: password,
    ));

    result.fold(
      (failure) {
        print('... ERRO: $failure message: ${failure.getMessage()}');
        String errorMessage = 'Falha ao tentar acesso. Tente novamente mais tarde';
        String failureMessage = failure.getMessage();

        if(failureMessage.contains('Forbidden') == true){
          errorMessage = 'Usuario/Senha invalido';
        }

        emit(state.copyWith(status: Status.failure, failure: failure, errorMessage: errorMessage));
      },
      (user) {
        // _saveUser(user); // isso foi delegado ao repository
        print('... Sucesso: $user');
        emit(state.copyWith(status: Status.success));
      },
    );
  }

  void goToHome() {
    sharedNavigator.openHome();
  }
}
