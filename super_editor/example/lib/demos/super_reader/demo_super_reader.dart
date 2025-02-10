import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_editor/super_editor.dart';
import 'package:super_editor_markdown/super_editor_markdown.dart';

import 'example_document.dart';

class SuperReaderDemo extends StatefulWidget {
  const SuperReaderDemo({Key? key}) : super(key: key);

  @override
  State<SuperReaderDemo> createState() => _SuperReaderDemoState();
}

class _SuperReaderDemoState extends State<SuperReaderDemo> {
  late final Document _document;
  final _selection = ValueNotifier<DocumentSelection?>(null);
  final _selectionLayerLinks = SelectionLayerLinks();
  late MagnifierAndToolbarController _overlayController;
  late final SuperReaderIosControlsController _iosReaderControlsController;

  bool initialized = false;
  @override
  void initState() {
    super.initState();

    () async {
      _document = await compute(
          deserializeMarkdownToDocument,
          """Benim adım ***Oben. Küçük*** de soyadım***dır***. ***Sikim*** de kutu kola **gibi*di*r**. Oben'in gözleri çakmak çakmaktır.

لعديد من الملفات على بيانات في شكل نص أو

# başlık nırada. ya da değil.
""" *
              10);

      setState(() {
        initialized = true;
      });
    }();

    _overlayController = MagnifierAndToolbarController();
    _iosReaderControlsController = SuperReaderIosControlsController(
      toolbarBuilder: _buildToolbar,
    );
  }

  @override
  void dispose() {
    _selection.dispose();
    _iosReaderControlsController.dispose();
    super.dispose();
  }

  void _copy() {
    if (_selection.value == null) {
      return;
    }

    final textToCopy = _textInSelection(
      document: _document,
      documentSelection: _selection.value!,
    );
    // TODO: figure out a general approach for asynchronous behaviors that
    //       need to be carried out in response to user input.
    _saveToClipboard(textToCopy);
  }

  String _textInSelection({
    required Document document,
    required DocumentSelection documentSelection,
  }) {
    final selectedNodes = document.getNodesInside(
      documentSelection.base,
      documentSelection.extent,
    );

    final buffer = StringBuffer();
    for (int i = 0; i < selectedNodes.length; ++i) {
      final selectedNode = selectedNodes[i];
      dynamic nodeSelection;

      if (i == 0) {
        // This is the first node and it may be partially selected.
        final baseSelectionPosition = selectedNode.id == documentSelection.base.nodeId
            ? documentSelection.base.nodePosition
            : documentSelection.extent.nodePosition;

        final extentSelectionPosition =
            selectedNodes.length > 1 ? selectedNode.endPosition : documentSelection.extent.nodePosition;

        nodeSelection = selectedNode.computeSelection(
          base: baseSelectionPosition,
          extent: extentSelectionPosition,
        );
      } else if (i == selectedNodes.length - 1) {
        // This is the last node and it may be partially selected.
        final nodePosition = selectedNode.id == documentSelection.base.nodeId
            ? documentSelection.base.nodePosition
            : documentSelection.extent.nodePosition;

        nodeSelection = selectedNode.computeSelection(
          base: selectedNode.beginningPosition,
          extent: nodePosition,
        );
      } else {
        // This node is fully selected. Copy the whole thing.
        nodeSelection = selectedNode.computeSelection(
          base: selectedNode.beginningPosition,
          extent: selectedNode.endPosition,
        );
      }

      final nodeContent = selectedNode.copyContent(nodeSelection);
      if (nodeContent != null) {
        buffer.write(nodeContent);
        if (i < selectedNodes.length - 1) {
          buffer.writeln();
        }
      }
    }
    return buffer.toString();
  }

  Future<void> _saveToClipboard(String text) {
    return Clipboard.setData(ClipboardData(text: text));
  }

  void _selectAll() {
    if (_document.isEmpty) {
      return;
    }

    _selection.value = DocumentSelection(
      base: DocumentPosition(
        nodeId: _document.first.id,
        nodePosition: _document.first.beginningPosition,
      ),
      extent: DocumentPosition(
        nodeId: _document.last.id,
        nodePosition: _document.last.endPosition,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(_selection.value?.end);
          final firstSentence = _document.first.asTextNode.text.sectences.last;
          _selection.value = DocumentSelection(
            base: DocumentPosition(
              nodeId: _document.last.id,
              nodePosition: TextNodePosition(offset: 0),
            ),
            extent: DocumentPosition(
              nodeId: _document.last.id,
              nodePosition: TextNodePosition(offset: 4),
            ),
          );
        },
        child: const Icon(Icons.select_all),
      ),
      body: initialized
          ? SuperReaderIosControlsScope(
              controller: _iosReaderControlsController,
              child: SuperReader(
                shrinkWrap: true,
                onSentenceTapped: (nodeId, text, index) {
                  if (nodeId != null) {
                    SentenceSelection.selectSentence(nodeId, index);
                  }
                },
                document: _document,
                selection: _selection,
                overlayController: _overlayController,
                selectionLayerLinks: _selectionLayerLinks,
                stylesheet: defaultStylesheet.copyWith(
                  addRulesAfter: [
                    taskStyles,
                  ],
                ),
                androidToolbarBuilder: (_) => AndroidTextEditingFloatingToolbar(
                  onCopyPressed: _copy,
                  onSelectAllPressed: _selectAll,
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildToolbar(context, mobileToolbarKey, focalPoint) {
    return IOSTextEditingFloatingToolbar(
      key: mobileToolbarKey,
      focalPoint: focalPoint,
      onCopyPressed: _copy,
    );
  }
}
