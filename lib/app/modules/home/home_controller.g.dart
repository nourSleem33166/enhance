// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$selectedPostsTypeAtom =
      Atom(name: '_HomeControllerBase.selectedPostsType');

  @override
  PostsType get selectedPostsType {
    _$selectedPostsTypeAtom.reportRead();
    return super.selectedPostsType;
  }

  @override
  set selectedPostsType(PostsType value) {
    _$selectedPostsTypeAtom.reportWrite(value, super.selectedPostsType, () {
      super.selectedPostsType = value;
    });
  }

  final _$pageStateAtom = Atom(name: '_HomeControllerBase.pageState');

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

  final _$loadingAtom = Atom(name: '_HomeControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$deletePostAsyncAction = AsyncAction('_HomeControllerBase.deletePost');

  @override
  Future<dynamic> deletePost(int postId) {
    return _$deletePostAsyncAction.run(() => super.deletePost(postId));
  }

  final _$communityPressedAsyncAction =
      AsyncAction('_HomeControllerBase.communityPressed');

  @override
  Future<dynamic> communityPressed() {
    return _$communityPressedAsyncAction.run(() => super.communityPressed());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic changePostsType(int type) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.changePostsType');
    try {
      return super.changePostsType(type);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void navigateToAddPost() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.navigateToAddPost');
    try {
      return super.navigateToAddPost();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedPostsType: ${selectedPostsType},
pageState: ${pageState},
loading: ${loading}
    ''';
  }
}
