import 'package:flutter/material.dart';
import 'package:flutter_caching/core.dart';

class ModeOfflineView extends StatefulWidget {
  const ModeOfflineView({super.key});

  Widget build(context, ModeOfflineController controller) {
    controller.view = this;
    return Scaffold(
      body: controller.isOffline
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_off, size: 24, color: Colors.red),
                      Text(
                        "You are currently offline",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.posts.length,
                      itemBuilder: (context, index) {
                        final post = controller.posts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue.shade100,
                              child: Text(
                                '${post['id']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(
                              post['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                post['body'],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            onTap: () {
                              // Navigate to detail page if needed
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text(
                "Internet connection is available",
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
            ),
    );
  }

  @override
  State<ModeOfflineView> createState() => ModeOfflineController();
}
