import 'package:example/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paginator/paginator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paginator Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<UserBloc>(
        create: (context) => UserBloc(),
        child: const UserListScreen(),
      ),
    );
  }
}

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  final int page = 1;

  @override
  Widget build(BuildContext context) {
    return PaginatedList(
      paginationDataFetcher: ({bool refreshFetching = false}) {
        context.read<UserBloc>().add(FetchUsersEvent(page: page));
      },
      builder: (context, scrollController) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("User List"),
            centerTitle: true,
          ),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserFetchFailure) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else if (state is UserFetchSuccess) {
                final users = state.users;

                return ListView.separated(
                  controller: scrollController,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                  shrinkWrap: true,
                  itemCount:
                      state.hasReachedEnd ? users.length : users.length + 1,
                  itemBuilder: (context, index) {
                    if (!state.hasReachedEnd && index >= users.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    final user = users[index];
                    return ListTile(
                      minTileHeight: 70,
                      leading: CircleAvatar(
                        radius: 16,
                        child: Text(user.id.toString()),
                      ),
                      minLeadingWidth: 50,
                      title: Text(user.name),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
