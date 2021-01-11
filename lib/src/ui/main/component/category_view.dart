import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_event.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_state.dart';
import 'package:flutter_bloc_base/src/data/constant/Constant.dart';
import 'package:flutter_bloc_base/src/data/repository/movie_repository_impl.dart';
import 'package:flutter_bloc_base/src/models/models.dart';
import 'package:flutter_bloc_base/src/ui/theme/colors.dart';
import 'package:flutter_bloc_base/src/ui/widget/error_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryView extends StatelessWidget {
  final Function(Movie) actionOpenCategory;
  CategoryView({Key key, @required this.actionOpenCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MovieBloc(MovieRepositoryImpl())..add(FetchMovieWithType(Constant.upcoming));
      },
      child: _createCategory(context),
    );
  }

  Widget _createCategory(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieInit) {
          return Center(child: const CircularProgressIndicator());
        } else if (state is MovieFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<MovieBloc>()..add(FetchMovieWithType(Constant.upcoming));
            },
          );
        } else if (state is MovieFetched) {
          return _createCategoryList(context, state.movies);
        } else {
          return Text(AppLocalizations.of(context).cannotSupport);
        }
      },
    );
  }

  Widget _createCategoryList(BuildContext context, List<Movie> movies) {
    return Container(
      width: double.infinity,
      height: 96.0,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _createCategoryItem(context, movies[index]);
        },
        itemCount: movies.length,
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => VerticalDivider(
          color: Colors.transparent,
          width: 6.0,
        ),
      ),
    );
  }

  Widget _createCategoryItem(BuildContext context, Movie movie) {
    final width = MediaQuery.of(context).size.width / 2.5;

    return InkWell(
      onTap: () {
        actionOpenCategory(movie);
      },
      child: Container(
        width: width,
        height: double.infinity,
        padding: EdgeInsets.only(bottom: 12.0),
        child: Card(
          elevation: 8.0,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            width: width,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    imageUrl: 'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                    width: width,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: width,
                    height: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.1, 0.5, 0.7, 0.9],
                        colors: [
                          Color(0x99ff0000),
                          Color(0x66ff0000),
                          Color(0x66ff0000),
                          Color(0x99ff0000),
                        ],
                      ),
                    ),
                    child: Text(
                      movie.releaseDate ?? '',
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontFamily: 'Muli',
                        color: white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
