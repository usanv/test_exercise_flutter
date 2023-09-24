import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/widgets.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> initConfig() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 1),
        minimumFetchInterval: const Duration(seconds: 10),
      ),
    );
    fetchConfig();
  }

  RemoteConfigService() {
    initConfig();
  }

  Future<void> fetchConfig() async {
    await _remoteConfig.fetchAndActivate();
  }

  String getLink() {
    debugPrint(_remoteConfig.getString('link'));
    return _remoteConfig.getString('link');
  }
}
