part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final Status status;
  final Failure? failure;
  final String errorMessage;

  const SignInState({
    this.status = Status.initial,
    this.failure,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [status, failure];

  SignInState copyWith({
    Status? status,
    Failure? failure,
    String? errorMessage,
  }) {
    return SignInState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}