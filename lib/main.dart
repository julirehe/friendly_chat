import 'package:flutter/material.dart';

void main() {
  runApp(
    FriendlyChatApp(),
  );
}

class FriendlyChatApp extends StatelessWidget {
  const FriendlyChatApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FriendlyChat',
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Friendly Chat')),
      body: _buildTextComposer(), // NEW
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(children: [
        Flexible(
          child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmitted,
            decoration:
                const InputDecoration.collapsed(hintText: 'Send a message'),
          ),
        ),
        IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.secondary), // NEW
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text)),
          ),
        )
      ]),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
  }
}
