class SignInWithGoogleFailure implements Exception {
  const SignInWithGoogleFailure([
    this.message = '알 수 없는 오류',
  ]);

  factory SignInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const SignInWithGoogleFailure(
          '이미 인증된 계정이 있습니다.',
        );
      case 'invalid-credential':
        return const SignInWithGoogleFailure(
          '유효하지 않은 계정입니다',
        );
      case 'operation-not-allowed':
        return const SignInWithGoogleFailure(
          '허용되지 않은 요청입니다. 관리자에게 문의하세요',
        );
      case 'user-disabled':
        return const SignInWithGoogleFailure(
          '비활성화 된 유저입니다',
        );
      case 'user-not-found':
        return const SignInWithGoogleFailure(
          '이메일을 찾을 수 없습니다.',
        );
      case 'wrong-password':
        return const SignInWithGoogleFailure(
          '잘못된 비밀번호입니다.',
        );
      case 'invalid-verification-code':
        return const SignInWithGoogleFailure(
          '유효하지 않은 인증코드입니다.',
        );
      case 'invalid-verification-id':
        return const SignInWithGoogleFailure(
          '유효하지 않은 id입니다.',
        );
      default:
        return SignInWithGoogleFailure("알 수 없는 오류입니다. 관리자에게 문의하세요.\n$code");
    }
  }

  final String message;
}
