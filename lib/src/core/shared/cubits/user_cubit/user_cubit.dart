import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/res/config_imports.dart';
import '../../helpers/cache_service.dart';
import '../../../network/auth/token_storage.dart';
import '../../models/user_model.dart';

part 'user_state.dart';
part 'user_utils.dart';

/// Owns the logged-in user object + the "is signed in" state.
///
/// Tokens are NOT stored here — they live in [TokenStorage], which is
/// the source of truth queried by [AuthInterceptor] on every request.
/// `UserCubit` only delegates token writes to it.
///
/// Persistence
///   - User payload → encrypted disk via [SecureStorage].
///   - Tokens       → encrypted disk via [TokenStorage] (which itself
///     uses [SecureStorage]).
@lazySingleton
class UserCubit extends Cubit<UserState> with UserUtils {
  UserCubit(this._tokenStorage) : super(UserState.initial());

  final TokenStorage _tokenStorage;

  /// Static shortcut for places where DI access is awkward (e.g. global
  /// helpers). Prefer constructor injection in production code.
  static UserCubit get instance => injector<UserCubit>();

  // ── Public API ──────────────────────────────────────────────────

  /// Persist the user payload + tokens and flip the state to logged-in.
  Future<void> setUserLoggedIn({
    required UserModel user,
    required String token,
    String? refreshToken,
  }) async {
    await _tokenStorage.save(access: token, refresh: refreshToken);
    await _saveUser(user);
    emit(state.copyWith(userModel: user, userStatus: UserStatus.loggedIn));
  }

  /// Wipe both tokens and the cached user, then reset to the initial state.
  Future<void> logout() async {
    await _tokenStorage.clear();
    await SecureStorage.delete(_userKey);
    emit(UserState.initial());
  }

  /// Rotate the access (and optionally the refresh) token without
  /// changing the user payload — used by the silent-refresh flow.
  Future<void> updateToken(String token, {String? refreshToken}) {
    return _tokenStorage.save(access: token, refresh: refreshToken);
  }

  /// Update the cached user payload (e.g. after the user edits their profile).
  Future<void> updateUser(UserModel user) async {
    await _saveUser(user);
    emit(state.copyWith(userModel: user));
  }

  /// Restore previous session from encrypted storage. Returns true when
  /// a valid (token + user) pair was found.
  ///
  /// Call this once during bootstrap, after `setUpServiceLocator()`.
  Future<bool> init() async {
    await _tokenStorage.init();
    final userJson = await SecureStorage.read(_userKey);

    if (!_tokenStorage.hasAccessToken || userJson == null) return false;
    print('LOCAL USER');
    print(userJson);

    try {
      final user = UserModel.fromJson(
        jsonDecode(userJson) as Map<String, dynamic>,
      );
      emit(state.copyWith(userModel: user, userStatus: UserStatus.loggedIn));
      return true;
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('UserCubit.init: corrupt user payload — $e\n$st');
      }
      // Corrupt payload → wipe so the next app launch starts clean.
      await logout();
      return false;
    }
  }

  // ── Sugar ───────────────────────────────────────────────────────

  UserModel get user => state.userModel;
  bool get isUserLoggedIn => state.userStatus == UserStatus.loggedIn;
}
