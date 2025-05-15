import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_caching/core.dart';
import 'package:http/http.dart' as http;

class ModeOfflineController extends State<ModeOfflineView> {
  static late ModeOfflineController instance;
  late ModeOfflineView view;
  bool isOffline = false;
  StreamSubscription? streamSubscription;
  final bool _isAppInForeground = true;
  List posts = [];
  bool isLoading = false;
  String? error;

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
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      error = "Failed to load posts ";
      final localPosts = await loadPostsFromLocal();

      if (localPosts != null) {
        setState(() {
          posts = localPosts;
        });
      } else {
        posts = [];
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List?> loadPostsFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('cached_posts');
    if (jsonString != null) {
      final decoded = jsonDecode(jsonString);
      return decoded;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    instance = this;
    streamSubscription = InternetConnection().onStatusChange.listen((event) {
      // Update status jaringan hanya jika aplikasi di foreground
      if (_isAppInForeground) {
        updateConnectionStatus(event == InternetStatus.disconnected);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  Future<void> checkCurrentConnectionStatus() async {
    bool isConnected = await InternetConnection().hasInternetAccess;
    print('ini ada koneksi ga $isConnected');
    updateConnectionStatus(!isConnected);
  }

  updateConnectionStatus(bool connected) {
    fetchPosts();
    setState(() {
      isOffline = connected;
    });
  }

  void onReady() {
    checkCurrentConnectionStatus(); // initial check
  }

  @override
  void dispose() {
    streamSubscription!.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
