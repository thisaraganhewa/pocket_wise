import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_wise/features/auth/domain/entities/user_entity.dart';
import 'package:pocket_wise/features/auth/domain/usecases/sign_in_with_google_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final SignInWithGoogleUseCase signInWithGoogleUseCase;

  AuthBloc(this.signInWithGoogleUseCase) : super(AuthInitial())  {
    on<SignInWithGoogleEvent>((event, emit) async {

      emit(AuthLoading());

      try{
        final user = await signInWithGoogleUseCase.logOrRegister();

        emit(AuthSuccess(user!));

      }
      catch(e){
        emit(AuthError(e.toString()));
      }
    });
  }
}
