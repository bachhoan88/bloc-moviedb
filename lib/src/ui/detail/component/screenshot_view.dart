import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_event.dart';
import 'package:flutter_bloc_base/src/bloc/movie_image_bloc/movie_image_bloc.dart';
import 'package:flutter_bloc_base/src/bloc/movie_image_bloc/movie_image_event.dart';
import 'package:flutter_bloc_base/src/bloc/movie_image_bloc/movie_image_state.dart';
import 'package:flutter_bloc_base/src/data/constant/constant.dart';
import 'package:flutter_bloc_base/src/data/repository/movie_repository_impl.dart';
import 'package:flutter_bloc_base/src/models/models.dart';
import 'package:flutter_bloc_base/src/ui/theme/colors.dart';
import 'package:flutter_bloc_base/src/ui/widget/error_page.dart';
import 'package:flutter_gen/gen_l10n/resource.dart';

class ScreenshotView extends StatelessWidget {
  final int movieId;
  final Function(Img) actionOpenImage;
  final Function actionLoadAll;

  const ScreenshotView({Key key, @required this.movieId, @required this.actionOpenImage, @required this.actionLoadAll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MovieImageBloc(MovieRepositoryImpl())
          ..add(
            GetMovieImagesEvent(movieId),
          );
      },
      child: _createScreenshot(context),
    );
  }

  Widget _createScreenshot(BuildContext context) {
    return BlocBuilder<MovieImageBloc, MovieImageState>(
      builder: (context, state) {
        if (state is MovieImageInit) {
          return Center(child: const CircularProgressIndicator());
        } else if (state is GetMovieImagesError) {
          return ErrorPage(
            message: state.msg,
            retry: () {
              context.watch<MovieBloc>()..add(FetchMovieWithType(Constant.topRated));
            },
          );
        } else if (state is GetMovieImagesSuccess) {
          return _createScreenshotView(context, state.images.backdrops);
        } else {
          return Text(AppLocalizations.of(context).cannotSupport);
        }
      },
    );
  }

  Widget _createScreenshotView(BuildContext context, List<Img> backdrops) {
    final contentHeight = 2.0 * (MediaQuery.of(context).size.width / 2.2) / 3.0;
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 20.0, right: 16.0),
            height: 48.0,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    AppLocalizations.of(context).screenshot,
                    style: TextStyle(
                      color: groupTitleColor,
                      fontSize: 16.0,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward, color: groupTitleColor),
                  onPressed: () {
                    return actionLoadAll;
                  },
                )
              ],
            ),
          ),
          Container(
            height: contentHeight,
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return _createScreenshotItem(context, backdrops[index]);
              },
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => VerticalDivider(
                color: Colors.transparent,
                width: 6.0,
              ),
              itemCount: backdrops.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createScreenshotItem(BuildContext context, Img img) {
    final width = MediaQuery.of(context).size.width / 2.4;
    return InkWell(
      onTap: () {
        actionOpenImage(img);
      },
      child: Container(
        width: width,
        height: double.infinity,
        padding: EdgeInsets.only(bottom: 20.0),
        child: Card(
          elevation: 10.0,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            width: width,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                imageUrl: 'https://image.tmdb.org/t/p/w500${img.imagePath}',
                width: width,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
