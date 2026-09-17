import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Friend {
  String name;
  String message;
  String status;
  String game;
  bool unread;
  bool online;

  Friend({
    required this.name,
    required this.message,
    required this.status,
    required this.game,
    required this.unread,
    required this.online,
  });
}

List<Friend> friends = [
  Friend(
    name: "MissYouLikeKrazy",
    message: "",
    status: "Online",
    game: "VALORANT",
    unread: true,
    online: true,
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SocialScreen(),
    );
  }
}

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final String friendsText = 'Friends';
  final String messages = 'Messages';
  final String requests = 'Requests';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171314),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Social',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Text(
                  friendsText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 30),

                Text(
                  messages,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 30),

                Text(
                  requests,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Container(
              height: 55,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 18),

                  Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 30,
                  ),

                  SizedBox(width: 12),

                  Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            Row(
              children: [
                const Icon(
                  Icons.ac_unit,
                  color: Colors.red,
                  size: 26,
                ),

                const SizedBox(width: 12),

                const Text(
                  'VALORANT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 8),

                Text(
                  friends.length.toString(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  String displayName = "Unknown User";
                  String displayMessage = "No message available.";

                  if (friends[index].name.isNotEmpty) {
                    displayName = friends[index].name;
                  }

                  if (friends[index].message.isNotEmpty) {
                    displayMessage = friends[index].message;
                  }

                  return GestureDetector(
                    onTap: () {
                      friends[index].unread = false;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChatroomScreen(
                              friend: friends[index],
                            );
                          },
                        ),
                      );

                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.red,
                                  size: 32,
                                ),
                              ),

                              if (friends[index].online)
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      displayName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),

                                    const SizedBox(width: 8),

                                    if (friends[index].unread)
                                      const Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        size: 9,
                                      ),
                                  ],
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  displayMessage,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),

                                const SizedBox(height: 3),

                                Text(
                                  friends[index].status +
                                      " - " +
                                      friends[index].game,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatroomScreen extends StatefulWidget {
  final Friend friend;

  const ChatroomScreen({
    super.key,
    required this.friend,
  });

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String displayName = "Unknown User";
    String displayMessage = "No message available.";

    if (widget.friend.name.isNotEmpty) {
      displayName = widget.friend.name;
    }

    if (widget.friend.message.isNotEmpty) {
      displayMessage = widget.friend.message;
    }

    return Scaffold(
      backgroundColor: Colors.black26,

      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text(
          displayName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    displayMessage,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 59, 59, 59),
                      ),
                      filled: true,
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}