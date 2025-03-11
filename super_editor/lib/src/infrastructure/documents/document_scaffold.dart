import 'package:flutter/material.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:super_editor/src/default_editor/document_scrollable.dart';
import 'package:super_editor/super_editor.dart';

/// A scaffold that combines pieces to create a scrolling single-column document, with
/// gestures placed beneath the document.
///
/// This scaffold was created to de-duplicate significant overlap between `SuperEditor`
/// and `SuperReader`. This class is probably not generally useful.
class DocumentScaffold<ContextType> extends StatefulWidget {
  const DocumentScaffold({
    super.key,
    required this.documentLayoutLink,
    required this.documentLayoutKey,
    required this.viewportDecorationBuilder,
    required this.gestureBuilder,
    this.textInputBuilder,
    required this.mainScrollController,
    required this.autoScrollController,
    required this.boxKey,
    this.scrollToIndex,
    required this.document,
    required this.scroller,
    required this.presenter,
    required this.componentBuilders,
    required this.shrinkWrap,
    this.underlays = const [],
    this.overlays = const [],
    this.debugPaint = const DebugPaintConfig(),
    required this.onObserveAll,
  });

  final void Function(Map<BuildContext, ObserveModel>)? onObserveAll;

  /// [LayerLink] that's is attached to the document layout.
  final LayerLink documentLayoutLink;

  /// [GlobalKey] that's attached to the document layout.
  final GlobalKey documentLayoutKey;

  final GlobalKey boxKey;

  final Document document;

  final int? scrollToIndex;

  /// Builder that creates a gesture interaction widget, which is displayed
  /// beneath the document, at the same size as the viewport.
  final Widget Function(
    BuildContext context, {
    required Widget child,
  }) gestureBuilder;

  /// Builds the text input widget, if applicable. The text input system is placed
  /// above the gesture system and beneath viewport decoration.
  final Widget Function(
    BuildContext context, {
    required Widget child,
  })? textInputBuilder;

  /// Builds platform specific viewport decoration (such as toolbar overlay manager or magnifier overlay manager).
  final Widget Function(
    BuildContext context, {
    required Widget child,
  }) viewportDecorationBuilder;

  /// Controls scrolling when this [DocumentScaffold] adds its own `Scrollable`, but
  /// doesn't provide scrolling control when this [DocumentScaffold] uses an ancestor
  /// `Scrollable`.
  final ScrollController mainScrollController;

  /// Controls auto-scrolling of the document's viewport.
  final AutoScrollController autoScrollController;

  /// A [DocumentScroller], to which this scrollable attaches itself, so
  /// that external actors, such as keyboard handlers, can query and change
  /// the scroll offset.
  final DocumentScroller? scroller;

  /// Presenter that computes styles for a single-column layout, e.g., component padding,
  /// text styles, selection.
  final SingleColumnLayoutPresenter presenter;

  /// Priority list of widget factories that create instances of
  /// each visual component displayed in the document layout, e.g.,
  /// paragraph component, image component, horizontal rule component, etc.
  final List<ComponentBuilder> componentBuilders;

  /// Layers that are displayed below the document layout, aligned
  /// with the location and size of the document layout.
  final List<ContentLayerWidgetBuilder> underlays;

  /// Layers that are displayed on top of the document layout, aligned
  /// with the location and size of the document layout.
  final List<ContentLayerWidgetBuilder> overlays;

  /// Paints some extra visual ornamentation to help with debugging.
  final DebugPaintConfig debugPaint;

  /// Whether the document should shrink-wrap its content.
  /// Only used when the document is not inside a scrollable.
  final bool shrinkWrap;

  @override
  State<DocumentScaffold> createState() => _DocumentScaffoldState();
}

class _DocumentScaffoldState extends State<DocumentScaffold> {
  BuildContext? _sliverListCtx;

  late SliverObserverController observerController;

  @override
  void initState() {
    super.initState();

    observerController = SliverObserverController(controller: widget.mainScrollController);

    // Trigger an observation manually
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_sliverListCtx != null) {
        observerController.dispatchOnceObserve(
          sliverContext: _sliverListCtx!,
        );
      }
    });
  }

  Future<dynamic> _animateToIndex(int index) {
    return observerController.animateTo(
      sliverContext: _sliverListCtx,
      index: index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  void didUpdateWidget(DocumentScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollToIndex != widget.scrollToIndex) {
      if (widget.scrollToIndex != null) {
        _animateToIndex(widget.scrollToIndex!);
      }
    }
  }

  @override
  void dispose() {
    observerController.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var child = _buildGestureSystem(
      child: _buildDocumentLayout(),
    );
    if (widget.textInputBuilder != null) {
      child = widget.textInputBuilder!(context, child: child);
    }
    return _buildDocumentScrollable(
      child: widget.viewportDecorationBuilder(
        context,
        child: child,
      ),
    );
  }

  /// Builds the widget tree that scrolls the document. This subtree might
  /// introduce its own Scrollable, or it might defer to an ancestor
  /// scrollable. This subtree also hooks up auto-scrolling capabilities.
  Widget _buildDocumentScrollable({
    required Widget child,
  }) {
    return DocumentScrollable(
      boxKey: widget.boxKey,
      observerController: observerController,
      onObserveAll: widget.onObserveAll,
      sliverListContext: _sliverListCtx,
      autoScroller: widget.autoScrollController,
      scrollController: widget.mainScrollController,
      scrollingMinimapId: widget.debugPaint.scrollingMinimapId,
      scroller: widget.scroller,
      shrinkWrap: widget.shrinkWrap,
      showDebugPaint: widget.debugPaint.scrolling,
      child: child,
    );
  }

  /// Builds the widget tree that handles user gesture interaction
  /// with the document, e.g., mouse input on desktop, or touch input
  /// on mobile.
  Widget _buildGestureSystem({
    required Widget child,
  }) {
    return widget.gestureBuilder(context, child: child);
  }

  Widget _buildDocumentLayout() {
    return ContentLayers(
      content: (onBuildScheduled) => SingleColumnDocumentLayout(
        useSliverListContext: (context) => _sliverListCtx = context,
        boxKey: widget.boxKey,
        document: widget.document,
        scrollController: widget.mainScrollController,
        key: widget.documentLayoutKey,
        presenter: widget.presenter,
        componentBuilders: widget.componentBuilders,
        onBuildScheduled: onBuildScheduled,
        showDebugPaint: widget.debugPaint.layout,
      ),
      underlays: widget.underlays,
      overlays: widget.overlays,
    );
  }
}
