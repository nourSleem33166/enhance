// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_communities_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchCommunitiesController on _SearchCommunitiesControllerBase, Store {
  final _$isSearchingAtom =
      Atom(name: '_SearchCommunitiesControllerBase.isSearching');

  @override
  bool get isSearching {
    _$isSearchingAtom.reportRead();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.reportWrite(value, super.isSearching, () {
      super.isSearching = value;
    });
  }

  final _$searchForCommunityAsyncAction =
      AsyncAction('_SearchCommunitiesControllerBase.searchForCommunity');

  @override
  Future<dynamic> searchForCommunity(String query) {
    return _$searchForCommunityAsyncAction
        .run(() => super.searchForCommunity(query));
  }

  @override
  String toString() {
    return '''
isSearching: ${isSearching}
    ''';
  }
}
