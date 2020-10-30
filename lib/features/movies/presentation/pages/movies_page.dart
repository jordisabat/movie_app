import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/movie_bloc.dart';
import '../widgets/loading_widget.dart';
import '../widgets/movie_list_widget.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: getWidget(_selectedIndex, context),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.purple,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.thumb_up_off_alt),
              label: 'Popular',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Top Rated',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Now on cinema',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'Upcomming',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  BlocProvider<MovieBloc> buildBlocProvider(BuildContext context, String type) {
    return BlocProvider(
      create: (_) => sl<MovieBloc>()..add(GetMostPopularMoviesEvent()),
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is Loading) {
            return const LoadingWidget();
          } else if (state is Loaded) {
            return MovieList(movies: state.movies);
          } else if (state is Error) {
            return Text(state.message);
          }
          return Container();
        },
      ),
    );
  }

  Widget getWidget(int selectedIndex, BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return buildBlocProvider(context, 'popular');
      case 1:
        return TabMessage(listType: 'top rated');
      case 2:
        return TabMessage(listType: 'now playing');
      case 3:
        return TabMessage(listType: 'upcoming');
      default:
        return TabMessage(listType: 'error');
    }
  }
}

class TabMessage extends StatelessWidget {
  final String listType;

  const TabMessage({
    Key key,
    @required this.listType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

    return Center(
      child: Text(
        'List of $listType movies',
        style: optionStyle,
      ),
    );
  }
}
