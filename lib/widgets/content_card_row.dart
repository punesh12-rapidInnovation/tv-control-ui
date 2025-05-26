import 'package:flutter/material.dart';

class Paginated<T> {
  final int count;
  final List<T> data;
  Paginated({required this.count, required this.data});
}

class ContentCardRow extends StatefulWidget {
  final String title;
  final int cardsPerView;
  final double horizontalGap;
  final Future<Paginated<dynamic>> Function(int page)? handleApiCall;
  final Widget Function(BuildContext context, Map<String, dynamic> content, double width, int index)? cardBuilder;

  const ContentCardRow({
    super.key,
    required this.title,
    required this.handleApiCall,
    this.cardsPerView = 4,
    this.horizontalGap = 16.0,
    this.cardBuilder,
  });

  @override
  State<ContentCardRow> createState() => _ContentCardRowState();
}

class _ContentCardRowState extends State<ContentCardRow> {
  final ScrollController _scrollController = ScrollController();
  final List<FocusNode> _focusNodes = [];
  final GlobalKey _titleKey = GlobalKey();
  static const double _scrollPadding = 30.0;

  List<Map<String, dynamic>> _allItems = [];
  bool _isLoading = false;
  int _currentPage = 1;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    _loadMoreData();
  }

  Future<void> _loadMoreData() async {
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
    });

    try {
      if (widget.handleApiCall != null) {
        final paginated = await widget.handleApiCall!(_currentPage);

        // Accept both Map and already-Map objects
        final newItems = paginated.data.map<Map<String, dynamic>>((content) {
          if (content is Map<String, dynamic>) return content;
          if (content is dynamic && content.toJson != null) {
            return content.toJson() as Map<String, dynamic>;
          }
          throw Exception('Item is not a Map or does not have toJson');
        }).toList();

        if (newItems.isEmpty) {
          _hasMoreData = false;
        } else {
          setState(() {
            _allItems.addAll(newItems);
            _currentPage++;
            _focusNodes.addAll(List.generate(newItems.length, (_) => FocusNode()));
          });
        }
      } else {
        _hasMoreData = false;
      }
    } catch (e) {
      print('Error loading more data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleScroll() {
    if (_scrollController.position.pixels > 0) {
      if (_titleKey.currentContext != null) {
        Scrollable.ensureVisible(
          _titleKey.currentContext!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.0,
          alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
        );
      }
    }

    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _loadMoreData();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _scrollToCard(int index, double cardWidth) {
    final double scrollPosition = index * (cardWidth + widget.horizontalGap);
    _scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildDefaultCard(BuildContext context, Map<String, dynamic> item, double width, int index) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: item['color'] ?? Colors.grey,
              child: Center(
                child: Icon(
                  item['icon'] ?? Icons.image,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item['subtitle'] ?? '',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            key: _titleKey,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth - (widget.horizontalGap * 2);
                final cardWidth = (availableWidth - (widget.horizontalGap * (widget.cardsPerView - 1))) / widget.cardsPerView;

                // Always show the loader at the end, regardless of loading state or hasMoreData
                return ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: widget.horizontalGap / 2),
                  itemCount: _allItems.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _allItems.length) {
                      return SizedBox(
                        width: cardWidth,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final item = _allItems[index];
                    return Focus(
                      focusNode: _focusNodes.length > index ? _focusNodes[index] : null,
                      onFocusChange: (hasFocus) {
                        if (hasFocus) {
                          _scrollToCard(index, cardWidth);
                        }
                      },
                      child: Builder(
                        builder: (context) {
                          final isFocused = Focus.of(context).hasFocus;
                          return Container(
                            width: cardWidth,
                            margin: EdgeInsets.symmetric(horizontal: widget.horizontalGap / 2),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isFocused ? Colors.white : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: widget.cardBuilder?.call(context, item, cardWidth, index) ??
                                _buildDefaultCard(context, item, cardWidth, index),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}