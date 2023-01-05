// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_post_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddPostController on _AddPostControllerBase, Store {
  final _$imageFileAtom = Atom(name: '_AddPostControllerBase.imageFile');

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

  final _$isAnonymousAtom = Atom(name: '_AddPostControllerBase.isAnonymous');

  @override
  bool get isAnonymous {
    _$isAnonymousAtom.reportRead();
    return super.isAnonymous;
  }

  @override
  set isAnonymous(bool value) {
    _$isAnonymousAtom.reportWrite(value, super.isAnonymous, () {
      super.isAnonymous = value;
    });
  }

  final _$pageStateAtom = Atom(name: '_AddPostControllerBase.pageState');

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

  final _$deleteImageAsyncAction =
      AsyncAction('_AddPostControllerBase.deleteImage');

  @override
  Future<dynamic> deleteImage() {
    return _$deleteImageAsyncAction.run(() => super.deleteImage());
  }

  final _$changeAnonyStateAsyncAction =
      AsyncAction('_AddPostControllerBase.changeAnonyState');

  @override
  Future<dynamic> changeAnonyState(bool value) {
    return _$changeAnonyStateAsyncAction
        .run(() => super.changeAnonyState(value));
  }

  @override
  String toString() {
    return '''
imageFile: ${imageFile},
isAnonymous: ${isAnonymous},
pageState: ${pageState}
    ''';
  }
}
