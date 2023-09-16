import 'package:core/core.dart';
import 'package:core_ui/views/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsCubit>(
          create: (context) =>
              NewsCubit(newsRepository: NewsRepository())..load(),
        ),
        BlocProvider<AppCoreCubit>(
          create: (context) => AppCoreCubit(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
      ],
      child: BlocListener<AppCoreCubit, AppCoreState>(
        listener: (context, state) {
          if (state is AppCoreLogout) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const SplashScreen(),
                ),
                (route) => false);
          }
          if (state is AppCoreLogoutError) {
            UtilFunctions.showInSnackBar(
                context, 'Something went wrong, Try again');
          }
        },
        child: const _HomeScreenView(),
      ),
    );
  }
}

class _HomeScreenView extends StatelessWidget {
  const _HomeScreenView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.blue,
            ),
            const Text(
              'Search',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => _onTapLogout(context),
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(
              child: Text('Loading...'),
            );
          }
          if (state is NewsError) {
            return const Center(
              child: Text('Something thing went wrong, try again'),
            );
          }
          if (state is NewsSuccess) {
            return _Details(state.articles);
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _onTapLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => BlocProvider<AppCoreCubit>.value(
        value: context.read<AppCoreCubit>(),
        child: AlertDialog(
          title: const Text("Logout Alert!"),
          content: const Text(
            "Are you sure want to logout?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 17,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<AppCoreCubit>().logout();
                Navigator.of(ctx).pop();
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details(this.articles);
  final List<Articles> articles;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      separatorBuilder: (context, int index) {
        return const SizedBox(height: 20);
      },
      itemCount: articles.length,
      itemBuilder: (context, int index) {
        return _NewTile(
          article: articles[index],
        );
      },
    );
  }
}

class _NewTile extends StatelessWidget {
  const _NewTile({required this.article});

  final Articles article;
  @override
  Widget build(BuildContext context) {
    final DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss'");
    final DateTime dateTime = format.parse(article.publishedAt!);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      dateTime.timeAgo(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      article.source!.name!,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    article.title!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  article.description!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          SizedBox(
            height: 90,
            width: 100,
            child: Image.network(article.urlToImage.toString(), errorBuilder:
                (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
              return const Icon(
                Icons.image,
                size: 70,
              );
            }),
          ),
        ],
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
