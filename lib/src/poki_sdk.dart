import 'dart:js_interop';
import 'package:flutter_poki_sdk/src/js_map_extensions.dart';

import 'flutter_poki_sdk_interop.dart' as interop;

/// A Flutter plugin for the Poki SDK.
///
/// Designed based on this doc:
/// https://sdk.poki.com/html5.html
class PokiSDK {
  // Make the constructor private to prevent instantiation
  PokiSDK._();

  static bool _isInitialized = false;

  static bool get isInitialized => _isInitialized;

  /// Initialize the SDK at the start of your game with the following method:
  static Future<void> init() async {
    if (_isInitialized) {
      return;
    }
    try {
      await interop.init().toDart;
      _isInitialized = true;
    } catch (e) {
      rethrow;
    }
  }

  /// In order to provide an accurate conversion to play metric for your game,
  /// please fire the following events when your loading has finished:
  static void gameLoadingFinished() => interop.gameLoadingFinished();

  /// Use the  🎮 gameplayStart()  event to describe when users are playing
  /// your game (e.g. level start and unpause).
  static void gameplayStart() => interop.gameplayStart();

  /// Use the  ☠ gameplayStop()  event to describe when users aren’t playing
  /// your game (e.g. level finish, game over, pause, quit to menu).
  static void gameplayStop() => interop.gameplayStop();

  /// Commercial breaks are used to display video ads and should be triggered
  /// on natural breaks in your game. Throughout the rest of your game,
  /// we recommend you implement the  🎞 commercialBreak()
  /// before every  🎮 gameplayStart() , i.e. whenever the user has shown
  /// an intent to continue playing.
  ///
  /// Not every single  🎞 commercialBreak()  will trigger an ad.
  /// Poki’s system will determine when a user is ready for another ad,
  /// so feel free to signal as many commercial break opportunities as possible.
  static Future<void> commercialBreak({
    required void Function() onStarted,
  }) =>
      interop.commercialBreak(onStarted.toJS).toDart;

  /// Trigger a rewarded break and return success status.
  ///
  /// Rewarded breaks allow for a user to choose to watch a rewarded video ad
  /// in exchange for a certain benefit in the game (e.g. more coins, etc.).
  /// When using  🎬 rewardedBreak() , please make it clear to the player
  /// beforehand that they’re about to watch an ad.
  ///
  ///  🎬 rewardedBreak()  affects the timing of  🎞 commercialBreak()  -
  ///  When a user interacts with a rewarded break, our system’s ad timer
  ///  is reset to ensure the user does not immediately see another ad.
  static Future<bool> rewardedBreak({
    required void Function() onStarted,
  }) async {
    JSBoolean resp = await interop.rewardedBreak(onStarted.toJS).toDart;
    return resp.toDart;
  }

  /// Generate a shareable URL with parameters.
  static Future<String> shareableURL(Map<String, String> params) async {
    final JSString jsString = await interop
        .shareableURL(
          params.toJSObject,
        )
        .toDart;
    return jsString.toDart;
  }

  /// Retrieve a parameter from the URL.
  static String getURLParam(String paramName) =>
      interop.getURLParam(paramName.toJS).toDart;
}
