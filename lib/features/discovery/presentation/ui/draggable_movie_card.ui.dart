import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:movie_helper/core/ui/movie_poster.ui.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';

enum UserMovieIntent { favorite, dismiss, none }

class DraggableMovieCardUi extends StatefulWidget {
  final Function(MovieEntity) onFavorite;
  final Function() onDismiss;
  final MovieEntity movie;
  final Size displaySize;

  const DraggableMovieCardUi({
    required GlobalKey<_DraggableMovieCardUiState> key,
    required this.displaySize,
    required this.onFavorite,
    required this.onDismiss,
    required this.movie,
  }) : super(key: key);

  GlobalKey<_DraggableMovieCardUiState> get globalKey =>
      key as GlobalKey<_DraggableMovieCardUiState>;

  @override
  State<DraggableMovieCardUi> createState() => _DraggableMovieCardUiState();
}

class _DraggableMovieCardUiState extends State<DraggableMovieCardUi>
    with SingleTickerProviderStateMixin {
  static const _dismissAlignment = Alignment(-20, 0);
  static const _favoriteAlignment = Alignment(20, 0);

  late final AnimationController _controller;
  late Animation<Alignment> _animation;

  Alignment _dragAlignment = Alignment.center;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
        if (_dragAlignment.x < -19) {
          widget.onDismiss();
        } else if (_dragAlignment.x > 19) {
          widget.onFavorite(widget.movie);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) => _controller.stop(),
      onPanUpdate: _handleOnPanUpdate,
      onPanEnd: _handleOnPanEnd,
      child: Align(
        alignment: _dragAlignment,
        child: MoviePosterUi(
          posterPath: widget.movie.posterPath,
          title: widget.movie.title,
        ),
      ),
    );
  }

  void runAnimation(Offset pixelsPerSecond,
      {UserMovieIntent userMovieIntent = UserMovieIntent.none}) {
    Alignment newAlignment;

    switch (userMovieIntent) {
      case UserMovieIntent.favorite:
        newAlignment = _favoriteAlignment;
        break;
      case UserMovieIntent.dismiss:
        newAlignment = _dismissAlignment;
        break;
      case UserMovieIntent.none:
        newAlignment = Alignment.center;
        break;
    }

    _animation = _controller.drive(
      AlignmentTween(begin: _dragAlignment, end: newAlignment),
    );

    final unitsPerSecondX = pixelsPerSecond.dx / widget.displaySize.width;
    final unitsPerSecondY = pixelsPerSecond.dy / widget.displaySize.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  void _handleOnPanUpdate(details) {
    setState(() {
      _dragAlignment += Alignment(
        details.delta.dx / (widget.displaySize.width / 10),
        details.delta.dy / (widget.displaySize.height / 10),
      );
    });
  }

  void _handleOnPanEnd(details) {
    UserMovieIntent userMovieIntent;

    if (_dragAlignment.x > 2) {
      userMovieIntent = UserMovieIntent.favorite;
    } else if (_dragAlignment.x < -2) {
      userMovieIntent = UserMovieIntent.dismiss;
    } else {
      userMovieIntent = UserMovieIntent.none;
    }

    runAnimation(
      details.velocity.pixelsPerSecond,
      userMovieIntent: userMovieIntent,
    );
  }
}
