import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketServices with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket? _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket? get socket => _socket;
  Function? get emit => _socket?.emit;

  SocketServices() {
    this._initConfig();
  }

  void _initConfig() {
    _socket = IO.io(
        'http://192.168.0.9:3001/',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect() // disable auto-connection
            .build());

    _socket?.onConnect((_) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
      //socket.emit('msg', 'test');
    });

    _socket?.onDisconnect((_) {
      print('disconnect');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
    /*socket.on('nuevo-mensaje', (payload) {
      print('nuevoMensaje: $payload');
    });*/

    _socket?.on('fromServer', (_) => print(_));
  }
}
