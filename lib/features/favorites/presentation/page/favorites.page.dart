import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_helper/core/controller/base_bloc.state.dart';
import 'package:movie_helper/core/page/base.page.abstract.dart';
import 'package:movie_helper/core/ui/movie_poster.ui.dart';
import 'package:movie_helper/features/favorites/presentation/controller/favorites.bloc.dart';
import 'package:movie_helper/features/favorites/presentation/controller/favorites.state.dart';

class FavoritesPage extends BasePage<FavoritesBloc> {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  String get pageTitle => 'Favorites';

  @override
  bool get canPop => true;

  @override
  void listener(BuildContext context, BaseBlocState state) {}

  @override
  Widget layout(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BlocBuilder<FavoritesBloc, BaseBlocState>(builder: (ctx, state) {
      return ListView.builder(
        itemCount: state is FavoritesState ? state.movieList.length : 1,
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          if (state is FavoritesState) {
            return Container(
              width: double.infinity,
              height: deviceSize.height * 0.32,
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  MoviePosterUi(
                    posterPath: state.movieList[index].posterPath,
                    title: '',
                    height: deviceSize.height * 0.32,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.movieList[index].title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          'Nota: ${state.movieList[index].voteAverage}',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      );
    });
  }
}
