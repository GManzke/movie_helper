import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_helper/core/constants.dart';
import 'package:movie_helper/core/controller/base_bloc.state.dart';
import 'package:movie_helper/core/page/base.page.abstract.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/discovery/presentation/controller/discovery.bloc.dart';
import 'package:movie_helper/features/discovery/presentation/controller/discovery.event.dart';
import 'package:movie_helper/features/discovery/presentation/controller/discovery.state.dart';
import 'package:movie_helper/features/discovery/presentation/ui/discovery_action_buttons.ui.dart';
import 'package:movie_helper/features/discovery/presentation/ui/draggable_movie_card.ui.dart';

class DiscoveryPage extends BasePage<DiscoveryBloc> {
  const DiscoveryPage({Key? key}) : super(key: key);

  @override
  String get pageTitle => 'Discovery';

  @override
  void listener(BuildContext context, BaseBlocState state) {}

  @override
  Widget layout(BuildContext context) {
    final displaySize = MediaQuery.of(context).size;

    return BlocBuilder<DiscoveryBloc, BaseBlocState>(
      builder: (ctx, state) {
        if (state is DiscoveryLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DiscoveryState) {
          final movieList = _generateMovieList(
              movieList: state.movieList,
              displaySize: displaySize,
              onFavorite: (movie) =>
                  bloc(ctx).add(FavoriteMovieDiscoveryEvent(movie)),
              onDismiss: () => bloc(ctx).add(DismissMovieDiscoveryEvent()));

          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: kDefaultPadding,
                right: kDefaultPadding,
                child: Text(
                  'Você chegou ao fim! Volte mais tarde para ver mais novidades',
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ),
              if (state is DiscoveryState && state.movieList.isNotEmpty)
                Positioned(
                  bottom: kDefaultPadding,
                  right: 0,
                  left: 0,
                  child: DiscoveryActionButtons(
                      onFavoritePressed: () =>
                          onFavoritePressed(movieList.last),
                      onDismissPressed: () => onDismissPressed(movieList.last)),
                ),
              Positioned.fill(
                bottom: displaySize.height * .15,
                child: Stack(children: movieList),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  List<DraggableMovieCardUi> _generateMovieList({
    required Function(MovieEntity) onFavorite,
    required List<MovieEntity> movieList,
    required Function() onDismiss,
    required Size displaySize,
  }) =>
      movieList.reversed
          .map(
            (movie) => DraggableMovieCardUi(
              key: GlobalKey(),
              displaySize: displaySize,
              onFavorite: onFavorite,
              onDismiss: onDismiss,
              movie: movie,
            ),
          )
          .toList();

  void onDismissPressed(DraggableMovieCardUi currentMovieCard) {
    currentMovieCard.globalKey.currentState!.runAnimation(
      const Offset(0, 0),
      userMovieIntent: UserMovieIntent.dismiss,
    );
  }

  void onFavoritePressed(DraggableMovieCardUi currentMovieCard) {
    currentMovieCard.globalKey.currentState!.runAnimation(
      const Offset(0, 0),
      userMovieIntent: UserMovieIntent.favorite,
    );
  }
}
