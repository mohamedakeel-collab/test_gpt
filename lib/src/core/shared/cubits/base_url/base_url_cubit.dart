import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/config_imports.dart';
import '../../../network/error/failures.dart';
import '../../helpers/cache_service.dart';
import '../../../state/async/async_cubit.dart';

@injectable
class BaseUrlCubit extends AsyncCubit<String?> {
  BaseUrlCubit();

  Future<bool> fetchBaseUrl() async {
    final String? storedBaseUrl = await SecureStorage.read(
      SecureLocalVariableKeys.baseUrlKey,
    );

    final bool hasStoredBaseUrl =
        storedBaseUrl != null && storedBaseUrl.isNotEmpty;

    int attempts = 0;

    while (true) {
      try {
        final remoteConfig = await _prepareRemoteConfig();
        final fetched = await _fetchAndStoreRemoteValue(
          remoteConfig: remoteConfig,
          key: SecureLocalVariableKeys.baseUrlKey,
          isRequired: true,
        );
        setData(fetched);
        return true;
      } catch (_) {
        attempts++;

        if (hasStoredBaseUrl && attempts >= 2) {
          setData(storedBaseUrl);
          return true;
        }

        if (!hasStoredBaseUrl && attempts >= 5) {
          setFailure(
            ServerFailure(customMessage: LocaleKeys.dataUpdatingNowComeLater),
          );
          return false;
        }

        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  Future<FirebaseRemoteConfig> _prepareRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await remoteConfig.fetchAndActivate();
    return remoteConfig;
  }

  Future<String> _fetchAndStoreRemoteValue({
    required FirebaseRemoteConfig remoteConfig,
    required String key,
    required bool isRequired,
  }) async {
    final value = remoteConfig.getString(key).trim();

    if (isRequired && value.isEmpty) {
      throw Exception('Empty value for key $key from remote config');
    }

    await SecureStorage.write(key, value);
    return value;
  }
}
