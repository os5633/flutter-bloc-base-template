class ErrorMessage {
  static String getValue(int errorCode) {
    switch (errorCode) {
      case 401:
        return "인증에 실패 하였습니다.";
      case 403:
        return "인증에 실패 하였습니다.";

      default:
        return "네트워크 오류입니다 관리자에 문의 부탁드립니다.";
    }
  }
}
