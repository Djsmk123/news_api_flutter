import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Features/Feed/bloc/feed_bloc.dart';

class ViewFeed extends StatefulWidget {
  const ViewFeed({super.key});

  @override
  State<ViewFeed> createState() => _ViewFeedState();
}

class _ViewFeedState extends State<ViewFeed> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<FeedBloc>(context).add(FeedFatchEvent());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FeedBloc>(context).add(FeedFatchEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
        centerTitle: true,
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FeedFailure) {
            return Center(
                child: Text(
              state.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
