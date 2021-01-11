import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_base/src/models/models.dart';
import 'package:flutter_bloc_base/src/ui/detail/detail_screen.dart';
import 'package:flutter_bloc_base/src/ui/theme/colors.dart';
import 'component/view.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomeScreen> implements AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 4.0,
        backgroundColor: primaryColor,
        title: Image.asset(
          'assets/images/ic_netflix.png',
          height: 56.0,
          fit: BoxFit.fitHeight,
        ),
        centerTitle: true,
        leading: Container(
          padding: EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: Icon(Icons.menu_rounded, color: actionBarIconColor),
            onPressed: () {},
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.search, color: actionBarIconColor),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0.0,
      ),
      backgroundColor: backgroundColor,
      body: _createBody(context),
    );
  }

  Widget _createBody(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Container(
              child: Column(
                children: [
                  SliderView(
                    actionOpenMovie: (movie) {
                      _openMovieDetail(movie);
                    },
                  ),
                  Divider(height: 4.0, color: Colors.transparent),
                  CategoryView(
                    actionOpenCategory: (movie) {
                      _openMovieDetail(movie);
                    },
                  ),
                  Divider(height: 8.0, color: Colors.transparent),
                  MyListView(
                    actionOpenMovie: (movie) {
                      _openMovieDetail(movie);
                    },
                    actionLoadAll: () {},
                  ),
                  Divider(height: 8.0, color: Colors.transparent),
                  PopularView(
                    actionOpenMovie: (movie) {
                      _openMovieDetail(movie);
                    },
                    actionLoadAll: () {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _openMovieDetail(Movie movie) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return DetailScreen(movie: movie);
      }),
    );
  }

  @override
  void updateKeepAlive() {}

  @override
  bool get wantKeepAlive => true;
}
