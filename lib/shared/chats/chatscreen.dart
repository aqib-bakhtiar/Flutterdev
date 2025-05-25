import 'package:flutter/material.dart';

class Chatscreen extends StatelessWidget {
  const Chatscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, //<<<<<number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chats"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicator: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            tabs: const [Tab(text: "Manager"), Tab(text: "Worker")],
          ),
        ),
        body: TabBarView(
          children: [
            // Manager Tab
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.pushNamed(context, '/chats');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          children: const [
                            Icon(Icons.person, color: Colors.blue),
                            SizedBox(width: 16),
                            Text(
                              'Go to Manager Chat',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(child: Center(child: Text("Manager Chat"))),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.pushNamed(context, '/chats');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          children: const [
                            Icon(Icons.group, color: Colors.green),
                            SizedBox(width: 16),
                            Text(
                              'Go to Worker Chat',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(child: Center(child: Text("Worker Chat"))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
