import 'package:flutter/material.dart';

void main() {
  runApp(
    FriendlyChatApp(),
  );
}

String _name = 'Julian';

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

class ChatMessage extends StatelessWidget {
  const ChatMessage({required this.text, Key? key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: Text(_name[0])),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_name, style: Theme.of(context).textTheme.headline4),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(text),
              ),
            ],
          ),
        ],
      ),
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
  final List<ChatMessage> _messages = []; // NEW
  final FocusNode _focusNode = FocusNode();    // NEW

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Friendly Chat')),
      body: Column(                                            // MODIFIED
        children: [                                            // NEW
          Flexible(                                            // NEW
            child: ListView.builder(                           // NEW
              padding: const EdgeInsets.all(8.0),              // NEW
              reverse: true,                                   // NEW
              itemBuilder: (_, index) => _messages[index],     // NEW
              itemCount: _messages.length,                     // NEW
            ),                                                 // NEW
          ),                                                   // NEW
          const Divider(height: 1.0),                          // NEW
          Container(                                           // NEW
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor),             // NEW
            child: _buildTextComposer(),                       // MODIFIED
          ),                                                   // NEW
        ],                                                     // NEW
      ),                                                       // NEW
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
            focusNode: _focusNode,  // NEW

          ),
        ),
        IconTheme(
          data: IconThemeData(
              color: Theme.of(context).colorScheme.secondary), // NEW
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
    var message = ChatMessage(
      // NEW
      text: text, // NEW
    ); // NEW
    setState(() {
      // NEW
      _messages.insert(0, message); // NEW
    }); // NEW
    _focusNode.requestFocus();  // NEW

  }
}
