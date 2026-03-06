sealed class Result<T> {}

class Succes<T> extends Result<T> {
  final T? data;
  Succes({this.data});
}

class Error<T> extends Result<T> {
  final String message;
  Error(this.message);
}
