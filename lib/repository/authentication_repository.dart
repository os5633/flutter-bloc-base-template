import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_base_template/support/support.dart';

import 'base_repository.dart';
import 'model/models.dart';

class AuthenticationRepository extends BaseRepository {
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  @visibleForTesting
  static const memberCacheKey = '__member_cache_key__';

  Stream<MemberDefault> get member {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      log(']-----] AuthenticationRepository::authStateChanges.firebaseUser [-----[ $firebaseUser');
      final MemberDefault member =
          firebaseUser == null || firebaseUser.isAnonymous
              ? MemberDefault.empty
              : firebaseUser.toMember;
      _cache.write(key: memberCacheKey, value: member);
      return member;
    });
  }

  MemberDefault get currentMember {
    return _cache.read<MemberDefault>(key: memberCacheKey) ??
        MemberDefault.empty;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signInByAnonymously() async {
    log("]-----] AuthenticationRepository::signInByAnonymously [-----[ ");
    if (_firebaseAuth.currentUser == null) {
      await _firebaseAuth.signInAnonymously();
    }
  }
}

extension on firebase_auth.User {
  MemberDefault get toMember {
    log("]-----] providerData [-----[ $providerData");
    return MemberDefault(
      id: -1,
      firebaseUid: uid,
      accountUniqueKey: displayName ?? uid,
    );
  }
}
