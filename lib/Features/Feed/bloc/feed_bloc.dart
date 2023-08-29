import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Features/data/model/news_model.dart';
import 'package:news/Features/data/repo/new_repo.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedInitial()) {
    on<FeedEvent>((event, emit) async {
      if (event is FeedFatchEvent) {
        emit(FeedLoading());
        final res = await NewsRepo.getArticle();
        if (res.$1 != null) {
          emit(FeedFailure(res.$1!.message));
        } else {
          emit(FeedSuccess(res.$2!));
        }
      }
    });
  }
}
