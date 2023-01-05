// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpController on _SignUpControllerBase, Store {
  Computed<bool> _$validDataComputed;

  @override
  bool get validData =>
      (_$validDataComputed ??= Computed<bool>(() => super.validData,
              name: '_SignUpControllerBase.validData'))
          .value;

  final _$selectedCityAtom = Atom(name: '_SignUpControllerBase.selectedCity');

  @override
  City get selectedCity {
    _$selectedCityAtom.reportRead();
    return super.selectedCity;
  }

  @override
  set selectedCity(City value) {
    _$selectedCityAtom.reportWrite(value, super.selectedCity, () {
      super.selectedCity = value;
    });
  }

  final _$selectedCountryAtom =
      Atom(name: '_SignUpControllerBase.selectedCountry');

  @override
  CountryModel get selectedCountry {
    _$selectedCountryAtom.reportRead();
    return super.selectedCountry;
  }

  @override
  set selectedCountry(CountryModel value) {
    _$selectedCountryAtom.reportWrite(value, super.selectedCountry, () {
      super.selectedCountry = value;
    });
  }

  final _$imageFileAtom = Atom(name: '_SignUpControllerBase.imageFile');

  @override
  File get imageFile {
    _$imageFileAtom.reportRead();
    return super.imageFile;
  }

  @override
  set imageFile(File value) {
    _$imageFileAtom.reportWrite(value, super.imageFile, () {
      super.imageFile = value;
    });
  }

  final _$inviteToOtherCommunitiesAtom =
      Atom(name: '_SignUpControllerBase.inviteToOtherCommunities');

  @override
  bool get inviteToOtherCommunities {
    _$inviteToOtherCommunitiesAtom.reportRead();
    return super.inviteToOtherCommunities;
  }

  @override
  set inviteToOtherCommunities(bool value) {
    _$inviteToOtherCommunitiesAtom
        .reportWrite(value, super.inviteToOtherCommunities, () {
      super.inviteToOtherCommunities = value;
    });
  }

  final _$pageStateAtom = Atom(name: '_SignUpControllerBase.pageState');

  @override
  PageState get pageState {
    _$pageStateAtom.reportRead();
    return super.pageState;
  }

  @override
  set pageState(PageState value) {
    _$pageStateAtom.reportWrite(value, super.pageState, () {
      super.pageState = value;
    });
  }

  final _$currentPageAtom = Atom(name: '_SignUpControllerBase.currentPage');

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  final _$validEmailAtom = Atom(name: '_SignUpControllerBase.validEmail');

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

  final _$validFirstNameAtom =
      Atom(name: '_SignUpControllerBase.validFirstName');

  @override
  bool get validFirstName {
    _$validFirstNameAtom.reportRead();
    return super.validFirstName;
  }

  @override
  set validFirstName(bool value) {
    _$validFirstNameAtom.reportWrite(value, super.validFirstName, () {
      super.validFirstName = value;
    });
  }

  final _$validLastNameAtom = Atom(name: '_SignUpControllerBase.validLastName');

  @override
  bool get validLastName {
    _$validLastNameAtom.reportRead();
    return super.validLastName;
  }

  @override
  set validLastName(bool value) {
    _$validLastNameAtom.reportWrite(value, super.validLastName, () {
      super.validLastName = value;
    });
  }

  final _$validAgeAtom = Atom(name: '_SignUpControllerBase.validAge');

  @override
  bool get validAge {
    _$validAgeAtom.reportRead();
    return super.validAge;
  }

  @override
  set validAge(bool value) {
    _$validAgeAtom.reportWrite(value, super.validAge, () {
      super.validAge = value;
    });
  }

  final _$validPhoneAtom = Atom(name: '_SignUpControllerBase.validPhone');

  @override
  bool get validPhone {
    _$validPhoneAtom.reportRead();
    return super.validPhone;
  }

  @override
  set validPhone(bool value) {
    _$validPhoneAtom.reportWrite(value, super.validPhone, () {
      super.validPhone = value;
    });
  }

  final _$validProfessionAtom =
      Atom(name: '_SignUpControllerBase.validProfession');

  @override
  bool get validProfession {
    _$validProfessionAtom.reportRead();
    return super.validProfession;
  }

  @override
  set validProfession(bool value) {
    _$validProfessionAtom.reportWrite(value, super.validProfession, () {
      super.validProfession = value;
    });
  }

  final _$validPasswordAtom = Atom(name: '_SignUpControllerBase.validPassword');

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

  final _$pickImageAsyncAction = AsyncAction('_SignUpControllerBase.pickImage');

  @override
  Future<dynamic> pickImage() {
    return _$pickImageAsyncAction.run(() => super.pickImage());
  }

  final _$suggestionPressedAsyncAction =
      AsyncAction('_SignUpControllerBase.suggestionPressed');

  @override
  Future<dynamic> suggestionPressed(Category category) {
    return _$suggestionPressedAsyncAction
        .run(() => super.suggestionPressed(category));
  }

  final _$deleteCategoryPressedAsyncAction =
      AsyncAction('_SignUpControllerBase.deleteCategoryPressed');

  @override
  Future<dynamic> deleteCategoryPressed(Category category) {
    return _$deleteCategoryPressedAsyncAction
        .run(() => super.deleteCategoryPressed(category));
  }

  final _$signUpAsyncAction = AsyncAction('_SignUpControllerBase.signUp');

  @override
  Future<dynamic> signUp() {
    return _$signUpAsyncAction.run(() => super.signUp());
  }

  final _$resetPasswordAsyncAction =
      AsyncAction('_SignUpControllerBase.resetPassword');

  @override
  Future<dynamic> resetPassword() {
    return _$resetPasswordAsyncAction.run(() => super.resetPassword());
  }

  final _$_SignUpControllerBaseActionController =
      ActionController(name: '_SignUpControllerBase');

  @override
  List<Category> categoryTypingCallback(String pattern) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction(
        name: '_SignUpControllerBase.categoryTypingCallback');
    try {
      return super.categoryTypingCallback(pattern);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic selectCity(City city) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction(
        name: '_SignUpControllerBase.selectCity');
    try {
      return super.selectCity(city);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeInviteValue(bool value) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction(
        name: '_SignUpControllerBase.changeInviteValue');
    try {
      return super.changeInviteValue(value);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic selectCountry(CountryModel country) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction(
        name: '_SignUpControllerBase.selectCountry');
    try {
      return super.selectCountry(country);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateCurrentPage(int pageIndex) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction(
        name: '_SignUpControllerBase.updateCurrentPage');
    try {
      return super.updateCurrentPage(pageIndex);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCity: ${selectedCity},
selectedCountry: ${selectedCountry},
imageFile: ${imageFile},
inviteToOtherCommunities: ${inviteToOtherCommunities},
pageState: ${pageState},
currentPage: ${currentPage},
validEmail: ${validEmail},
validFirstName: ${validFirstName},
validLastName: ${validLastName},
validAge: ${validAge},
validPhone: ${validPhone},
validProfession: ${validProfession},
validPassword: ${validPassword},
validData: ${validData}
    ''';
  }
}
