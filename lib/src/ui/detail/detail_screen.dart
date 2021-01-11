import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_base/src/models/models.dart';
import 'package:flutter_bloc_base/src/ui/widget/favorite_icon_widget.dart';
import 'package:flutter_bloc_base/src/ui/detail/component/movie_info_view.dart';
import 'package:flutter_bloc_base/src/ui/detail/cubit/expand_cubit.dart';
import 'package:flutter_bloc_base/src/ui/theme/colors.dart';
import 'package:shape_of_view/shape_of_view.dart';

import 'component/screenshot_view.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: _createDetailBody(context),
      ),
      onWillPop: () async => true,
    );
  }

  Widget _createDetailBody(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Container(
                  child: Column(
                    children: [
                      _createDetailHeader(context),
                      MovieInfoView(movie: movie),
                      Divider(height: 8.0, color: Colors.transparent),
                      ScreenshotView(
                        movieId: movie.id,
                        actionOpenImage: (img) {},
                        actionLoadAll: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        _createAppbar(context),
      ],
    );
  }

  Widget _createDetailHeader(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: width + 56.0,
      child: Stack(
        children: [
          ShapeOfView(
            shape: ArcShape(
              direction: ArcDirection.Outside,
              height: 48,
              position: ArcPosition.Bottom,
            ),
            height: width,
            elevation: 24.0,
            child: Container(
              width: double.infinity,
              height: width,
              child: _createHeaderImage(context),
            ),
          ),
          _createHeaderAction(context),
        ],
      ),
    );
  }

  Widget _createAppbar(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        elevation: 0.0,
        titleSpacing: 4.0,
        backgroundColor: Colors.transparent,
        title: Image.asset(
          'assets/images/ic_netflix.png',
          height: 56.0,
          fit: BoxFit.fitHeight,
        ),
        centerTitle: true,
        leading: Container(
          padding: EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: actionBarIconColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 16.0),
            child: FavoriteIconWidget(isFavorite: false, onFavoriteChanged: (checked) {}),
          ),
        ],
      ),
    );
  }

  Widget _createHeaderImage(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.5, 0.7, 0.9],
              colors: [
                white20,
                white10,
                white05,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _createHeaderAction(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 16.0,
          bottom: 8.0,
          child: Container(
            width: 64.0,
            height: 64.0,
            child: FittedBox(
              child: IconButton(
                icon: Icon(Icons.add_rounded, color: actionBarIconColor),
                onPressed: () {},
              ),
            ),
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 8.0,
          child: Container(
            width: 64.0,
            height: 64.0,
            child: FittedBox(
              child: IconButton(
                icon: Icon(Icons.share_outlined, color: actionBarIconColor),
                onPressed: () {},
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 8.0,
          left: 0.0,
          right: 0.0,
          child: FractionalTranslation(
            translation: Offset(0.0, -0.2),
            child: Container(
              width: 72.0,
              height: 72.0,
              child: FittedBox(
                child: FloatingActionButton(
                  elevation: 10.0,
                  onPressed: () {},
                  backgroundColor: white,
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
