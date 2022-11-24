part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.member = MemberDefault.empty,
  });

  const AppState.authenticated(MemberDefault member)
      : this._(status: AppStatus.authenticated, member: member);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final MemberDefault member;

  @override
  List<Object> get props => [status, member];
}
