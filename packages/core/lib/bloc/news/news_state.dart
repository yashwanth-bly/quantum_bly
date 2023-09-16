part of 'news_cubit.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}
class NewsSuccess extends NewsState {
  const NewsSuccess({required this.articles});
   final List<Articles> articles;

  @override
  List<Object> get props => [articles];
}
class NewsError extends NewsState {
  @override
  List<Object> get props => [];
}
class NewsLoading extends NewsState {
  @override
  List<Object> get props => [];
}
