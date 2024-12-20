@JS('PokiSDK')
library;

import 'dart:js_interop';

/*
PokiSDK.init().then(() => {
    console.log("Poki SDK successfully initialized");
    // fire your function to continue to game
}).catch(() => {
    console.log("Initialized, something went wrong, load you game anyway");
    // fire your function to continue to game
});
*/
@JS()
external JSPromise<JSAny?> init();

/*
// fire loading function here
PokiSDK.gameLoadingFinished();
*/
@JS()
external void gameLoadingFinished();

/*
// first level loads, player clicks anywhere
PokiSDK.gameplayStart();
// player is playing
// player loses round
PokiSDK.gameplayStop();
// game over screen pops up
*/
@JS()
external void gameplayStart();

/*
// first level loads, player clicks anywhere
PokiSDK.gameplayStart();
// player is playing
// player loses round
PokiSDK.gameplayStop();
// game over screen pops up
*/
@JS()
external void gameplayStop();

/*
// pause your game here if it isn't already
PokiSDK.commercialBreak(() => {
  // you can pause any background music or other audio here
}).then(() => {
  console.log("Commercial break finished, proceeding to game");
  // if the audio was paused you can resume it here (keep in mind that the function above to pause it might not always get called)
  // continue your game here
});
---
// gameplay stops (don't forget to fire gameplayStop)
// fire your mute audio function
// fire your disable keyboard input function
PokiSDK.commercialBreak().then(() => {
    console.log("Commercial break finished, proceeding to game");
    // fire your unmute audio function
    // fire your enable keyboard input function
    PokiSDK.gameplayStart();
    // fire your function to continue to game
});
*/
@JS()
external JSPromise<JSAny?> commercialBreak([JSFunction onStarted]);

/*
// pause your game here if it isn't already
PokiSDK.rewardedBreak(() => {
  // you can pause any background music or other audio here
}).then((success) => {
    if(success) {
        // video was displayed, give reward
    } else {
        // video not displayed, should not give reward
    }
    // if the audio was paused you can resume it here (keep in mind that the function above to pause it might not always get called)
    console.log("Rewarded break finished, proceeding to game");
    // continue your game here
});
*/
@JS()
external JSPromise<JSBoolean> rewardedBreak(JSFunction onStart);

/*
PokiSDK.shareableURL({}).then(url => {});

// example
const params = {
    id: 'myid',
    type: 'mytype',
    // ... any other param
}

PokiSDK.shareableURL(params).then(url => {
    console.log(url);
    // if run on e.g. https://poki.com/en/g/my-awesome-game it will return https://poki.com/en/g/my-awesome-game?gdid=myid&gdtype=mytype
});
*/
@JS()
external JSPromise<JSString> shareableURL(JSObject params);

/*
PokiSDK.getURLParam('<param name>');
// example
const id = PokiSDK.getURLParam('id');
// this will return either the gdid param set on poki.com or the id param on the current url
*/
@JS()
external JSString getURLParam(JSString paramName);

// Both of these interfaces exist to call `Object.keys` from Dart.
//
// But you don't use them directly. Just see `jsToMap`.
@JS('Object.keys')
external JSArray<JSString> getKeysOfObject(JSObject jsObject);
