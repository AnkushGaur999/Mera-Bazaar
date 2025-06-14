// Mocks generated by Mockito 5.4.5 from annotations
// in mera_bazaar/test/src/data/repositories/category/category_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mera_bazaar/src/data/models/category/category_model.dart'
    as _i4;
import 'package:mera_bazaar/src/data/source/remote/category/category_data_source.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [CategoryDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCategoryDataSource extends _i1.Mock
    implements _i2.CategoryDataSource {
  MockCategoryDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.CategoryModel>> getCategory() =>
      (super.noSuchMethod(
            Invocation.method(#getCategory, []),
            returnValue: _i3.Future<List<_i4.CategoryModel>>.value(
              <_i4.CategoryModel>[],
            ),
          )
          as _i3.Future<List<_i4.CategoryModel>>);
}
