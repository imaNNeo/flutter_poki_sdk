# Flutter Poki Sdk
This is a Flutter package that provides a simple way to interact with the [Poki](https://poki.com/) API.
At this time, there's no official Poki API, so I decided to create one for Flutter. 
This package is based on the [Poki HTML5](https://sdk.poki.com/html5.html) SDK (which is using a .js file)

## Disclaimer
This package is not official and is not affiliated with Poki. It's just a simple way to interact with their API in a Flutter project.
There's no guarantee that this package will work in the future, as it's based on the HTML5 SDK and created on 2024-12-20.

## Installation
You just need to add this plugin in your `pubspec.yaml` file like this:
```yaml
dependencies:
	flutter_poki_sdk:
		git:
			url: git@github.com:imaNNeo/flutter_poki_sdk.git
```
Then, you have to add this line in your `index.html` file:
```html
<body>
	<!-- Other lines -->
	
	<!-- Add this line -->
	<script src="https://game-cdn.poki.com/scripts/v2/poki-sdk.js"></script>
</body>
```

Then, run `flutter pub get` in your terminal.


## How to use

Now, you're able to use the Poki SDK in your Flutter project (only works for web). 
Here's an example of how to use it:

```dart
import 'package:flutter_poki_sdk/flutter_poki_sdk.dart';

void main() async {
  try {
    await PokiSDK.init();
    debugPrint('SDK initialized');

    // Now you can use other functions such as:
    PokiSDK.gameLoadingFinished();
    PokiSDK.gameplayStart();
    PokiSDK.gameplayStop();
    final commercialBreakResult = await PokiSDK.commercialBreak(onStarted: () {
      debugPrint('commercialBreak started');
    });
    final rewardedBreakResult = await PokiSDK.rewardedBreak(onStarted: () {
      debugPrint('rewardedBreak started');
    });
    final shareableURL = await PokiSDK.shareableURL({'playerId': 'imaNNeo'});
    final playerId = PokiSDK.getURLParam('playerId');
    debugPrint('playerId is $playerId');
  } catch (e) {
    debugPrint('SDK initialization failed: $e');
  }
  runApp(const MyApp());
}
```

Please read more about the available functions in their official HTML5 SDK [here](https://sdk.poki.com/html5.html).
Then you will know how to use them in your Flutter game