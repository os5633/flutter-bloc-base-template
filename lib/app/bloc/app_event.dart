part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppSignOutRequested extends AppEvent {}

class AppMemberChanged extends AppEvent {
  @visibleForTesting
  const AppMemberChanged(this.member);

  final MemberDefault member;

  @override
  List<Object> get props => [member];
}
