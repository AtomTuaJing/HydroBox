import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hydrobox/services/navigation.dart';

class ConnectedOrNotConnected extends StatefulWidget {
  const ConnectedOrNotConnected({super.key});

  @override
  State<ConnectedOrNotConnected> createState() =>
      _ConnectedOrNotConnectedState();
}

class _ConnectedOrNotConnectedState extends State<ConnectedOrNotConnected> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterBluePlus.events.onConnectionStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.connectionState ==
              BluetoothConnectionState.connected) {
            return const Navigation(connectionState: true);
          } else {
            return const Navigation(connectionState: false);
          }
        } else {
          return const Navigation(connectionState: false);
        }
      },
    );
  }
}
