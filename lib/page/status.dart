import 'package:band_name/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketProvider = Provider.of<SocketServices>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Server status: ${socketProvider.serverStatus}')],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          socketProvider.emit!('emitir-mensaje',
              {"nombre": 'Flutter', "mensaje": 'Hola desde flutter'});
        },
        child: Icon(Icons.message),
      ),
    );
  }
}
