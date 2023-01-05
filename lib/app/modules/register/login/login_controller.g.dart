// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  Computed<bool> _$loginButtonEnabledComputed;

  @override
  bool get loginButtonEnabled => (_$loginButtonEnabledComputed ??=
          Computed<bool>(() => super.loginButtonEnabled,
              name: '_LoginControllerBase.loginButtonEnabled'))
      .value;

  final _$validEmailAtom = Atom(name: '_LoginControllerBase.validEmail');

  @override
  bool get validEmail {
    _$validEmailAtom.reportRead();
    return super.validEmail;
  }

  @override
  set validEmail(bool value) {
    _$validEmailAtom.reportWrite(value, super.validEmail, () {
      super.validEmail = value;
    });
  }

  final _$validPasswordAtom = Atom(name: '_LoginControllerBase.validPassword');

  @override
  bool get validPassword {
    _$validPasswordAtom.reportRead();
    return super.validPassword;
  }

  @override
  set validPassword(bool value) {
    _$validPasswordAtom.reportWrite(value, super.validPassword, () {
      super.validPassword = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_LoginControllerBase.login');

  @override
  Future<dynamic> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  final _$resetPasswordAsyncAction =
      AsyncAction('_LoginControllerBase.resetPassword');

  @override
  Future<dynamic> resetPassword() {
    return _$resetPasswordAsyncAction.run(() => super.resetPassword());
  }

  @override
  String toString() {
    return '''
validEmail: ${validEmail},
validPassword: ${validPassword},
loginButtonEnabled: ${loginButtonEnabled}
    ''';
  }
}
