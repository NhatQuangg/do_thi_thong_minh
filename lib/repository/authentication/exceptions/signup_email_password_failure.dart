class SignUpWithEmailAndPasswordFailure {
  final String message;

  SignUpWithEmailAndPasswordFailure([this.message = "An Unknown error occured"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch(code) {
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure('Vui lòng nhập mật khẩu mạnh');
      case 'invalid-email':
        return SignUpWithEmailAndPasswordFailure('Email không hợp lệ');
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure('Email này đã được sử dụng');
      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordFailure('Hệ thống không được cho phép. Vui lòng liên hệ hỗ trợ');
      case 'user-disabled':
        return SignUpWithEmailAndPasswordFailure('Tài khoản này đã bị vô hiệu hóa. Vui lòng liên hệ hỗ trợ');
      default:
        return SignUpWithEmailAndPasswordFailure();
    }
  }
}