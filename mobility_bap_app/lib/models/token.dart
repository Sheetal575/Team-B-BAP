class Token {
  final bool _exists;
  final String _token;
  Token(this._exists, this._token);
  bool doesExist() {
    return this._exists;
  }

  String getToken() {
    return this._token;
  }
}
