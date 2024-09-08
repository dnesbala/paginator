import 'package:flutter/material.dart';

typedef DataFetcher = void Function({bool refreshFetching});

class PaginatedList extends StatefulWidget {
  final DataFetcher paginationDataFetcher;
  final Widget Function(BuildContext context, ScrollController scrollController)
      builder;

  const PaginatedList({
    super.key,
    required this.paginationDataFetcher,
    required this.builder,
  });

  @override
  State<PaginatedList> createState() => _PaginatedListState();
}

class _PaginatedListState extends State<PaginatedList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // load initial/fresh data
    widget.paginationDataFetcher(refreshFetching: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      widget.paginationDataFetcher(refreshFetching: false);
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _scrollController);
  }
}
