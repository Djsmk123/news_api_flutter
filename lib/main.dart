import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Features/Feed/bloc/feed_bloc.dart';
import 'package:news/Features/View/feed_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (create) => FeedBloc())],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ViewFeed(),
      ),
    );
  }
}
