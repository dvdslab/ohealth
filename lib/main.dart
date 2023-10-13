import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:uuid/uuid.dart';


Future<void> backgroundHandler(RemoteMessage message) async{
  debugPrint('Title: ${message.notification?.title}');
  debugPrint('Body:  ${message.notification?.body}');
  debugPrint('payload:  ${message.data}');

  // AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: 10,
  //       channelKey: "test_notification",
  //       color: Colors.white,
  //       title: message.notification?.title,
  //       body: message.notification?.body,
  //       category: NotificationCategory.Call,
  //       notificationLayout: NotificationLayout.Default,
  //       wakeUpScreen: true,
  //       fullScreenIntent: true,
  //       autoDismissible: false,
  //       backgroundColor: Colors.indigoAccent,
  //       criticalAlert: true,
  //       displayOnBackground: true,
  //       displayOnForeground: true,
  //     ),
  //     actionButtons: [
  //       NotificationActionButton(
  //           key: "ACCEPT",
  //           label: "Accept Call",
  //           color: Colors.green,
  //           autoDismissible: true
  //       ),
  //       NotificationActionButton(
  //           key: "REJECT",
  //           label: "Reject Call",
  //           color: Colors.red,
  //           autoDismissible: true
  //       )
  //     ]
  // );
  showCallkitIncoming();
}

Future<void> showCallkitIncoming() async {
  CallKitParams params=const CallKitParams(
      id: "21232dgfgbcbgb",
      nameCaller: "Coding Is Life",
      appName: "Demo",
      avatar: "https://i.pravata.cc/100",
      handle: "123456",
      type: 0,
      textAccept: "Accept",
      textDecline: "Decline",
      // textMissedCall: "Missed call",
      // textCallback: "Call back",
      duration: 30000,
      extra: {'userId':"sdhsjjfhuwhf"},
      android: AndroidParams(
          isCustomNotification: true,
          isShowLogo: false,
          // isShowCallback: false,
          // isShowMissedCallNotification: true,
          ringtonePath: 'system_ringtone_default',
          backgroundColor: "#0955fa",
          backgroundUrl: "https://i.pravata.cc/500",
          actionColor: "#4CAF50",
          incomingCallNotificationChannelName: "Incoming call",
          missedCallNotificationChannelName: "Missed call"
      ),
      ios: IOSParams(
          iconName: "Call Demo",
          handleType: 'generic',
          supportsVideo: true,
          maximumCallGroups: 2,
          maximumCallsPerCallGroup: 1,
          audioSessionMode: 'default',
          audioSessionActive: true,
          audioSessionPreferredSampleRate: 44100.0,
          audioSessionPreferredIOBufferDuration: 0.005,
          supportsDTMF: true,
          supportsHolding: true,
          supportsGrouping: false,
          ringtonePath: 'system_ringtone_default'
      )
  );
  await FlutterCallkitIncoming.showCallkitIncoming(params);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
          channelGroupKey: 'test_notification',
          channelKey: 'test_notification',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          defaultRingtoneType: DefaultRingtoneType.Ringtone,
          importance: NotificationImportance.Max,
          locked: true,
          channelShowBadge: true
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? token;
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

    });
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    getToken();
  }

  void getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {}); // Update the state to reflect the fetched token
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: token ?? 'No token available'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Token has been copied to clipboard'),
      ),
    );
  }

  // int _counter = 0;

  void _incrementCounter() {
    setState(() async{
      String? token = await FirebaseMessaging.instance.getToken();
      debugPrint(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100,),
            ElevatedButton(onPressed: () async{
              debugPrint('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n here');
              CallKitParams params = const CallKitParams(
                id: "lewm232",
                nameCaller: 'Hien Nguyen',
                handle: '0123456789',
                type: 1,
                // textMissedCall: 'Missed call',
                // textCallback: 'Call back',
                extra: <String, dynamic>{'userId': '1a2b3c4d'},
              );
              await FlutterCallkitIncoming.showMissCallNotification(params);
            },
                child: const Text('Missed Call') ),
            const SizedBox(height: 20,),
            //outgoing call

            ElevatedButton(onPressed: ()async{
              try{
                CallKitParams params = const CallKitParams(
                    id: "576ug",
                    nameCaller: 'Hien Nguyen',
                    handle: '0123456789',
                    type: 1,
                    extra: <String, dynamic>{'userId': '1a2b3c4d'},
                    ios: IOSParams(handleType: 'generic')
                );
                await FlutterCallkitIncoming.startCall(params);
              }catch(e){
                debugPrint("EXCE=====$e");
              }
            }, child: const Text("OutGoing")),
            //we will check it latter
            const SizedBox(height: 20,),
            //incoming call
            ElevatedButton(onPressed: ()async{
              CallKitParams params=const CallKitParams(
                  id: "21232dgfgbcbgb",
                  nameCaller: "Coding Is Life",
                  appName: "Demo",
                  avatar: "https://i.pravata.cc/100",
                  handle: "123456",
                  type: 0,
                  textAccept: "Accept",
                  textDecline: "Decline",
                  // textMissedCall: "Missed call",
                  // textCallback: "Call back",
                  duration: 30000,
                  extra: {'userId':"sdhsjjfhuwhf"},
                  android: AndroidParams(
                      isCustomNotification: true,
                      isShowLogo: false,
                      // isShowCallback: false,
                      // isShowMissedCallNotification: true,
                      ringtonePath: 'system_ringtone_default',
                      backgroundColor: "#0955fa",
                      backgroundUrl: "https://i.pravata.cc/500",
                      actionColor: "#4CAF50",
                      incomingCallNotificationChannelName: "Incoming call",
                      missedCallNotificationChannelName: "Missed call"
                  ),
                  ios: IOSParams(
                      iconName: "Call Demo",
                      handleType: 'generic',
                      supportsVideo: true,
                      maximumCallGroups: 2,
                      maximumCallsPerCallGroup: 1,
                      audioSessionMode: 'default',
                      audioSessionActive: true,
                      audioSessionPreferredSampleRate: 44100.0,
                      audioSessionPreferredIOBufferDuration: 0.005,
                      supportsDTMF: true,
                      supportsHolding: true,
                      supportsGrouping: false,
                      ringtonePath: 'system_ringtone_default'
                  )
              );
              await FlutterCallkitIncoming.showCallkitIncoming(params);
            }, child: const Text("Incoming")),

            const SizedBox(height: 20,),

            ElevatedButton(onPressed: ()async{
              String? token = await FirebaseMessaging.instance.getToken();
              debugPrint(token);
            }, child: const Text("Let a Nigga know")),

            const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              child: Column(
                children: [
                  const Text(
                    'Token to be copied', // Replace with the text you want to copy
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: copyToClipboard,
                    child: const Text('Copy to Clipboard'),
                  ),
                ],
              ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add_a_photo_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
