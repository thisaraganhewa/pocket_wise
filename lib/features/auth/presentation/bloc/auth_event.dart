part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  
}

class SignInWithGoogleEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
