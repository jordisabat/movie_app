import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/movie_bloc.dart';
import '../widgets/loading_widget.dart';
import '../widgets/movie_list_widget.dart';

class MoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          )
        ],
      ),
      body: buildBlocProvider(context),
    );
  }

  BlocProvider<MovieBloc> buildBlocProvider(BuildContext context) {
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
          return Container(
            height: MediaQuery.of(context).size.height / 3,
            child: const Placeholder(),
          );
        },
      ),
    );
  }
}
