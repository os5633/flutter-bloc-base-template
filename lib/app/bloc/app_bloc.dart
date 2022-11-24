import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_base_template/repository/model/models.dart';
import 'package:flutter_bloc_base_template/repository/repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentMember.isEmpty
              ? const AppState.unauthenticated()
              : AppState.authenticated(authenticationRepository.currentMember),
        ) {
    on<AppMemberChanged>(_onMemberChanged);
    on<AppSignOutRequested>(_onSignOutRequested);
    _memberSubscription = _authenticationRepository.member.listen(
      (member) => add(AppMemberChanged(member)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<MemberDefault> _memberSubscription;

  Future<void> signInByAnonymously() async {
    log("]-----] AppBloc::signInByAnonymously [-----[ $state");
    await _authenticationRepository.signInByAnonymously();
  }

  void _onMemberChanged(AppMemberChanged event, Emitter<AppState> emit) {
    emit(
      event.member.isEmpty
          ? const AppState.unauthenticated()
          : AppState.authenticated(event.member),
    );
  }

  void _onSignOutRequested(
      AppSignOutRequested event, Emitter<AppState> emit) async {
    log("]-----] AppBloc::_onSignOutRequested [-----[ $state");
    await _authenticationRepository.signOut();
  }

  @override
  Future<void> close() {
    _memberSubscription.cancel();
    return super.close();
  }
}
