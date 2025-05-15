import 'package:flutter/material.dart';
import 'package:flutter_caching/core.dart';

class FormController extends State<FormView> {
  static late FormController instance;
  late FormView view;
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void submitForm() {
    if (formKey.currentState!.validate()) {
      final name = fullNameController.text;
      final email = emailController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Submitted: $name | $email')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() {}

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
