

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


enum ServerStatus {
  Online,
  Offline,
  Connecting 
}
class SocketService with ChangeNotifier{
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;
  
  SocketService (){
    this._initConfig();
  }

  void _initConfig(){
// Dart client
 this._socket = IO.io('http://192.168.0.106:3000',{
   'transports': ['websocket'],
   'autoConnect': true
 });
    this. _socket.on('connect', (_) {
     print('connect');
    this._socket.emit('msg', 'test');
    });
    this._socket.on('disconnect', (_) => print('disconnect'));
  }
}