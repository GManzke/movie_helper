import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_helper/core/constants.dart';

class MoviePosterUi extends StatelessWidget {
  static const kImageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const kPosterRatio = 0.7;

  const MoviePosterUi({
    Key? key,
    required this.voteAverage,
    required this.height,
    required this.title,
    this.posterPath,
  }) : super(key: key);

  const MoviePosterUi.posterOnly({
    Key? key,
    required this.height,
    this.posterPath,
  })  : title = '',
        voteAverage = null,
        super(key: key);

  final String? posterPath;
  final double? voteAverage;
  final double height;
  final String title;

  @override
  Widget build(BuildContext context) {
    final width = kPosterRatio * height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CachedNetworkImage(
            imageUrl: kImageBaseUrl + (posterPath ?? ''),
            fit: BoxFit.cover,
            height: height,
            width: width,
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[800],
              child: const Icon(Icons.error_outline),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Container(
              color: Colors.grey[800],
              child: Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress)),
            ),
          ),
          Positioned.fill(
            child: Container(
                padding: EdgeInsetsDirectional.only(
                    bottom: kDefaultPadding, top: height / 2),
                width: width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black87],
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter,
                    stops: [0, 1],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (title.isNotEmpty)
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headline2,
                        textAlign: TextAlign.center,
                      ),
                    if (voteAverage != null)
                      Text(
                        'Nota: $voteAverage',
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
