import 'package:flutter/material.dart';
import 'package:flutter_poki_sdk/flutter_poki_sdk.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInitialized = false;
  String? initializeError;

  bool isLoadingFinished = false;

  bool isPlaying = false;

  @override
  void initState() {
    _initializeSdk();
    super.initState();
  }

  void _initializeSdk() async {
    PokiSDK.init().then((asdf) {
      setState(() {
        isInitialized = true;
      });
    }).onError((e, stackTrace) {
      setState(() {
        initializeError = e.toString();
        isInitialized = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Is Initialized: '),
                Text(
                  isInitialized ? 'Yes' : 'No',
                  style: TextStyle(
                    color: isInitialized ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (initializeError != null)
              Text(
                initializeError!,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            Expanded(child: Container()),
            ...[
              ElevatedButton(
                onPressed: isLoadingFinished  ? null : () async {
                  try {
                    PokiSDK.gameLoadingFinished();
                    setState(() {
                      isLoadingFinished = true;
                    });
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('Game loading finished'),
              ),
              ElevatedButton(
                onPressed: !isLoadingFinished || isPlaying ? null : () async {
                  try {
                    PokiSDK.gameplayStart();
                    setState(() {
                      isPlaying = true;
                    });
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('gameplayStart'),
              ),
              ElevatedButton(
                onPressed: !isLoadingFinished || !isPlaying ? null : () async {
                  try {
                    PokiSDK.gameplayStop();
                    setState(() {
                      isPlaying = false;
                    });
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('gameplayEnd'),
              ),
              ElevatedButton(
                onPressed: !isLoadingFinished || isPlaying? null : () async {
                  try {
                    await PokiSDK.commercialBreak(
                      onStarted: () {
                        debugPrint('commercialBreak started');
                      },
                    );
                    if (!context.mounted) {
                      return;
                    }
                    await _showAdSuccessDialog(context);
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('Commercial Ad Break'),
              ),
              ElevatedButton(
                onPressed: !isLoadingFinished || isPlaying? null : () async {
                  await PokiSDK.rewardedBreak(
                    onStarted: () {
                      debugPrint('rewardedBreak started');
                    },
                  );
                  if (!context.mounted) {
                    return;
                  }
                  await _showAdSuccessDialog(context);
                },
                child: const Text('Rewarded Ad Break'),
              ),
              ElevatedButton(
                onPressed: !isLoadingFinished ? null : () async {
                  final url = await PokiSDK.shareableURL({'playerId': 'imaNNeo'});
                  if (!context.mounted) {
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(url)),
                  );
                },
                child: const Text('Shareable URL'),
              ),
              ElevatedButton(
                onPressed: !isLoadingFinished ? null : () async {
                  final value = PokiSDK.getURLParam('playerId');
                  if (!context.mounted) {
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('playerId is $value')),
                  );
                },
                child: const Text('Get URL Param'),
              ),
              Expanded(child: Container()),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _showAdSuccessDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ad Success'),
          content: const Text('Ad was successfully displayed'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
