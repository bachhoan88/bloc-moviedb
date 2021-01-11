import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_event.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_state.dart';
import 'package:flutter_bloc_base/src/data/constant/constant.dart';
import 'package:flutter_bloc_base/src/data/repository/movie_repository_impl.dart';
import 'package:flutter_bloc_base/src/models/models.dart';
import 'package:flutter_bloc_base/src/ui/theme/colors.dart';
import 'package:flutter_bloc_base/src/ui/widget/error_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PopularView extends StatelessWidget {
  final Function(Movie) actionOpenMovie;
  final Function actionLoadAll;

  const PopularView({Key key, @required this.actionOpenMovie, @required this.actionLoadAll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MovieBloc(MovieRepositoryImpl())
          ..add(
            FetchMovieWithType(Constant.popular),
          );
      },
      child: _createPopular(context),
    );
  }

  Widget _createPopular(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieInit) {
          return Center(child: const CircularProgressIndicator());
        } else if (state is MovieFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<MovieBloc>()..add(FetchMovieWithType(Constant.popular));
            },
          );
        } else if (state is MovieFetched) {
          return _createPopularView(context, state.movies);
        } else {
          return Text(AppLocalizations.of(context).cannotSupport);
        }
      },
    );
  }

  Widget _createPopularView(BuildContext context, List<Movie> movies) {
    final contentHeight = 4.0 * (MediaQuery.of(context).size.width / 2.4) / 3;
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
                    AppLocalizations.of(context).popular,
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
                  onPressed: () {},
                )
              ],
            ),
          ),
          Container(
            height: contentHeight,
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return _createPopularViewItem(context, movies[index]);
              },
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => VerticalDivider(
                color: Colors.transparent,
                width: 6.0,
              ),
              itemCount: movies.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createPopularViewItem(BuildContext context, Movie movie) {
    final width = MediaQuery.of(context).size.width / 2.6;
    return InkWell(
      onTap: () {
        actionOpenMovie(movie);
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
                imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
