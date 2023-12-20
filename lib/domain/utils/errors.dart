class Failure implements Exception {
  String? message;

  Failure({this.message = ""});
}

class RemoteFailure implements Failure {
  @override String? message;
  int? code;

  RemoteFailure({this.message = "Ocorreu um erro, tente novamente mais tarde", this.code});
}

class LoginError extends Failure {
  LoginError()
      : super(
      message:
      "Ocorreu um erro ao tentar realizar o login, tente novamente mais tarde!");
}

class StandardError extends Failure {
  StandardError()
      : super(message: "Ocorreu um erro, tente novamente mais tarde");
}

class InvalidUser extends Failure {
  InvalidUser() : super(message: "Favor realizar novamente o login");
}