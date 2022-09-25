import 'package:flutter/material.dart';

class StreamLoading {
  List<Widget> hasError(snapshot) {
    return <Widget>[
      const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text('Error: ${snapshot.error}'),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text('Stack trace: ${snapshot.stackTrace}'),
      ),
    ];
  }

  List<Widget> connectionStateNone(String text) {
    return <Widget>[
      // Image.asset('assets/bad.png'),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(text),
      )
    ];
  }

  List<Widget> connectionStateWaiting(String wait) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Center(
          child: Text(
            wait,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    ];
  }

  List<Widget> connectionStateDone() {
    return const <Widget>[
      SizedBox(
        width: 60,
        height: 60,
        child: CircularProgressIndicator(),
      ),
      Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text('done...'),
      )
    ];
  }
}
