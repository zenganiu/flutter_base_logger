import 'package:flutter/material.dart';
import 'package:flutter_base_logger/print/print_cell.dart';
import 'package:flutter_base_logger/print/print_entity.dart';
import 'package:flutter_base_logger/print/print_type.dart';
import 'package:flutter_base_logger/util/logger.dart';

class PrintView extends StatefulWidget {
  const PrintView({super.key});

  @override
  State<PrintView> createState() => _PrintViewState();
}

class _PrintViewState extends State<PrintView> {
  bool _showSearch = false;
  String keyword = "";
  late TextEditingController _textController;
  late ScrollController _scrollController;
  late FocusNode _focusNode;
  bool _goDown = true;
  List<PrintType> selectTypes = PrintType.values;

  @override
  void initState() {
    _textController = TextEditingController(text: keyword);
    _scrollController = ScrollController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTools(),
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: PrintEntity.length,
              builder: (context, value, child) {
                List<PrintEntity> logs = PrintEntity.list;
                if (keyword.isNotEmpty && logs.isNotEmpty) {
                  logs = logs.where((e) => e.contains(keyword)).toList();
                }
                if (selectTypes.length < PrintType.values.length && logs.isNotEmpty) {
                  logs = logs.where((e) => selectTypes.contains(e.type)).toList();
                }
                final len = logs.length;
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final item = Logger.config.hasReverse ? logs[len - index - 1] : logs[index];
                    return PrintCell(data: item);
                  },
                  itemCount: len,
                  controller: _scrollController,
                  separatorBuilder: (context, index) {
                    return Container();
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'dmcb_logger_print',
        onPressed: () {
          if (_goDown) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent * 2,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );
          } else {
            _scrollController.animateTo(0, curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
          }
          _goDown = !_goDown;
          setState(() {});
        },
        mini: true,
        child: Icon(_goDown ? Icons.arrow_downward : Icons.arrow_upward),
      ),
    );
  }

  Widget _buildTools() {
    final List<ChoiceChip> arr = [
      for (final e in PrintType.values)
        ChoiceChip.elevated(
          label: Text(
            e.tabFlag().replaceAll(RegExp(r"\[|\]"), ''),
            style: TextStyle(fontSize: 12, color: selectTypes.contains(e) ? Colors.white : Colors.black),
          ),
          selectedColor: Colors.blue,
          selected: selectTypes.contains(e),
          onSelected: (value) {
            if (selectTypes.contains(e)) {
              selectTypes = selectTypes.where((element) => element != e).toList();
            } else {
              selectTypes = [...selectTypes, e];
            }
            setState(() {});
          },
        ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 0, 5),
      child: AnimatedCrossFade(
        crossFadeState: _showSearch ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 300),
        firstChild: Row(
          children: [
            Expanded(child: Wrap(spacing: 5, children: arr)),
            const IconButton(icon: Icon(Icons.clear), onPressed: PrintEntity.clear),
            IconButton(
              icon: keyword.isEmpty ? const Icon(Icons.search) : const Icon(Icons.filter_1),
              onPressed: () {
                _showSearch = true;
                setState(() {});
                _focusNode.requestFocus();
              },
            ),
          ],
        ),
        secondChild: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 36,
                child: TextField(
                  decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.all(6)),
                  controller: _textController,
                  focusNode: _focusNode,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                _showSearch = false;
                keyword = _textController.text;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
