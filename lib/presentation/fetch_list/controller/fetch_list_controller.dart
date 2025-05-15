import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_caching/core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchListController extends State<FetchListView> {
  static late FetchListController instance;
  late FetchListView view;
  List posts = [];
  bool isLoading = false;
  String? error;
  @override
  void initState() {
    super.initState();
    fetchPosts();
    instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  Future fetchPosts() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if (response.statusCode == 200) {
        posts = jsonDecode(response.body);
        await savePostsToLocal(posts);
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      error = "Failed to load posts ";
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> savePostsToLocal(List posts) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(posts);
    await prefs.setString('cached_posts', jsonString);
  }

  void onReady() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
