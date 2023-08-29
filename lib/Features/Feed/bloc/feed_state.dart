part of 'feed_bloc.dart';

@immutable
abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedFailure extends FeedState {
  final String message;

  FeedFailure(this.message);
}

class FeedSuccess extends FeedState {
  final Article articles;

  FeedSuccess(this.articles);
}
