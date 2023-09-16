import 'package:core/core.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(NewsInitial());
  final NewsRepository _newsRepository;

  Future<void> load() async {
    emit(NewsLoading());
    try {
      final NewsResponse response = await _newsRepository.getNews();
      emit(NewsSuccess(articles: response.articles ?? []));
    } catch (e) {
      print(e);
      emit(NewsError());
    }
  }
}
