import 'package:flutter/material.dart';
import 'package:flutter_caching/core.dart';

class FetchListView extends StatefulWidget {
  const FetchListView({super.key});

  Widget build(context, FetchListController controller) {
    controller.view = this;
    return Scaffold(
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline,
                            color: Colors.red, size: 60),
                        const SizedBox(height: 12),
                        Text(
                          controller.error!,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: controller.fetchPosts,
                          icon: const Icon(Icons.refresh),
                          label: const Text("Try Again"),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: controller.fetchPosts,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                            // Navigasi ke detail jika diperlukan
                          },
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  @override
  State<FetchListView> createState() => FetchListController();
}
