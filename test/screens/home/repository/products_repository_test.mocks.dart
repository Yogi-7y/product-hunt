// Mocks generated by Mockito 5.0.15 from annotations
// in product_hunt/test/screens/home/repository/products_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:product_hunt/core/api/api_response.dart' as _i2;
import 'package:product_hunt/screens/home/datasources/local_data_source.dart'
    as _i7;
import 'package:product_hunt/screens/home/datasources/remote_data_source.dart'
    as _i5;
import 'package:product_hunt/screens/home/models/post_model.dart' as _i6;
import 'package:product_hunt/service/network_connectivity.dart' as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeCustomResponse_0<T> extends _i1.Fake implements _i2.ApiResponse<T> {}

/// A class which mocks [NetworkConnectivity].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkConnectivity extends _i1.Mock
    implements _i3.NetworkConnectivity {
  MockNetworkConnectivity() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [RemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteDataSource extends _i1.Mock
    implements _i5.RemoteDataSourceContract {
  MockRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.ApiResponse<List<_i6.PostModel>>> getTodaysPosts() =>
      (super.noSuchMethod(Invocation.method(#getTodaysPosts, []),
              returnValue: Future<_i2.ApiResponse<List<_i6.PostModel>>>.value(
                  _FakeCustomResponse_0<List<_i6.PostModel>>()))
          as _i4.Future<_i2.ApiResponse<List<_i6.PostModel>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [LocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDataSource extends _i1.Mock
    implements _i7.LocalDataSourceContract {
  MockLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.ApiResponse<List<_i6.PostModel>>> getTodaysPosts() =>
      (super.noSuchMethod(Invocation.method(#getTodaysPosts, []),
              returnValue: Future<_i2.ApiResponse<List<_i6.PostModel>>>.value(
                  _FakeCustomResponse_0<List<_i6.PostModel>>()))
          as _i4.Future<_i2.ApiResponse<List<_i6.PostModel>>>);
  @override
  _i4.Future<void> cacheTodaysPosts(List<_i6.PostModel>? posts) =>
      (super.noSuchMethod(Invocation.method(#cacheTodaysPosts, [posts]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  String toString() => super.toString();
}
