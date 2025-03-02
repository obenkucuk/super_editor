import 'package:flutter/rendering.dart';
import 'package:super_editor/super_editor.dart';

MutableDocument createInitialDocument(String a) {
  return MutableDocument(
    nodes: [
      ImageNode(
        id: "1",
        imageUrl: 'https://i.ibb.co/5nvRdx1/flutter-horizon.png',
        expectedBitmapSize: ExpectedSize(1911, 630),
        metadata: const SingleColumnLayoutComponentStyles(
          width: double.infinity,
          padding: EdgeInsets.zero,
        ).toMetadata(),
      ),
      ParagraphNode(
        id: Editor.createNodeId(),
        text: AttributedText('Welcome to Super Editor 💙 🚀'),
        metadata: {
          'blockType': header1Attribution,
        },
      ),
      ParagraphNode(
        id: Editor.createNodeId(),
        text: AttributedText(
          "Super Editor is a toolkit to help you build document editors, document layouts, text fields, and more.",
        ),
      ),
      ParagraphNode(
        id: Editor.createNodeId(),
        text: AttributedText('Ready-made solutions 📦'),
        metadata: {
          'blockType': header2Attribution,
        },
      ),
      ListItemNode.unordered(
        id: Editor.createNodeId(),
        text: AttributedText(
          'SuperEditor is a ready-made, configurable document editing experience.',
        ),
      ),
      ListItemNode.unordered(
        id: Editor.createNodeId(),
        text: AttributedText(
          'SuperTextField is a ready-made, configurable text field.',
        ),
      ),
      ParagraphNode(
        id: Editor.createNodeId(),
        text: AttributedText('Quickstart 🚀'),
        metadata: {
          'blockType': header2Attribution,
        },
      ),
      ParagraphNode(
        id: Editor.createNodeId(),
        text: AttributedText('To get started with your own editing experience, take the following steps:'),
      ),
      TaskNode(
        id: Editor.createNodeId(),
        isComplete: false,
        text: AttributedText(
          'Create and configure your document, for example, by creating a new MutableDocument.',
        ),
      ),
      TaskNode(
        id: Editor.createNodeId(),
        isComplete: false,
        text: AttributedText(
          "If you want programmatic control over the user's selection and styles, create a DocumentComposer.",
        ),
      ),
      TaskNode(
        id: Editor.createNodeId(),
        isComplete: false,
        text: AttributedText(
          "Build a SuperEditor widget in your widget tree, configured with your Document and (optionally) your DocumentComposer.",
        ),
      ),
      ParagraphNode(
        id: Editor.createNodeId(),
        text: AttributedText(
          "Now, you're off to the races! SuperEditor renders your document, and lets you select, insert, and delete content.",
        ),
      ),
      ParagraphNode(
        id: Editor.createNodeId(),
        text: AttributedText('Explore the toolkit 🔎'),
        metadata: {
          'blockType': header2Attribution,
        },
      ),
      ListItemNode.unordered(
        id: Editor.createNodeId(),
        text: AttributedText(
          "Use MutableDocument as an in-memory representation of a document.",
        ),
      ),
      ListItemNode.unordered(
        id: Editor.createNodeId(),
        text: AttributedText(
          "Implement your own document data store by implementing the Document api.",
        ),
      ),
      ListItemNode.unordered(
        id: Editor.createNodeId(),
        text: AttributedText(
          "Implement your down DocumentLayout to position and size document components however you'd like.",
        ),
      ),
      ListItemNode.unordered(
        id: Editor.createNodeId(),
        text: AttributedText(
          "Use SuperSelectableText to paint text with selection boxes and a caret.",
        ),
      ),
      ListItemNode.unordered(
        id: Editor.createNodeId(),
        text: AttributedText(
          'Use AttributedText to quickly and easily apply metadata spans to a string.',
        ),
      ),
      ...List.generate(
          100,
          (i) => ParagraphNode(
                id: Editor.createNodeId(),
                text: AttributedText(
                  "$i We hope you enjoy using Super Editor. Let us know what you're building, and please file issues for any bugs that you find.",
                ),
              ))
    ],
  );
}

MutableDocument createInitialDocumentCompute(String a) {
  return MutableDocument(
    nodes: [
      ImageNode(
        id: 'image',
        imageUrl: 'https://i.ibb.co/5nvRdx1/flutter-horizon.png',
        expectedBitmapSize: ExpectedSize(1911, 630),
        metadata: const SingleColumnLayoutComponentStyles(
          width: double.infinity,
          padding: EdgeInsets.zero,
        ).toMetadata(),
      ),
      ParagraphNode(
        id: Editor.createNodeId(),
        text: AttributedText('Welcome to Super Editor 💙 🚀'),
        metadata: {
          'blockType': header1Attribution,
        },
      ),
      ImageNode(
        id: 'image2',
        imageUrl:
            'https://images.unsplash.com/photo-1726137570057-2f410417c3ee?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        expectedBitmapSize: ExpectedSize(100, 50),
        metadata: const SingleColumnLayoutComponentStyles(
          width: double.infinity,
          padding: EdgeInsets.zero,
        ).toMetadata(),
      ),
      ParagraphNode(
        id: Editor.createNodeId(),
        text: AttributedText(
          "Super Editor is a toolkit to help you build document editors, document layouts, text fields, and more.",
        ),
      ),
      ParagraphNode(
        id: Editor.createNodeId(),
        text: AttributedText('Ready-made solutions 📦'),
        metadata: {
          'blockType': header2Attribution,
        },
      ),
      ListItemNode.unordered(
        id: Editor.createNodeId(),
        text: AttributedText(
          'SuperEditor is a ready-made, configurable document editing experience.',
        ),
      ),
      ListItemNode.unordered(
        id: Editor.createNodeId(),
        text: AttributedText(
          'SuperTextField is a ready-made, configurable text field.',
        ),
      ),
      ParagraphNode(
        id: Editor.createNodeId(),
        text: AttributedText('Quickstart 🚀'),
        metadata: {
          'blockType': header2Attribution,
        },
      ),

      TaskNode(
        id: '1',
        isComplete: false,
        text: AttributedText(
          'Create and configure your document, for example, by creating a new MutableDocument.',
        ),
      ),
      TaskNode(
        id: Editor.createNodeId(),
        isComplete: false,
        text: AttributedText(
          "If you want programmatic control over the user's selection and styles, create a DocumentComposer.",
        ),
      ),
      TaskNode(
        id: Editor.createNodeId(),
        isComplete: false,
        text: AttributedText(
          "Build a SuperEditor widget in your widget tree, configured with your Document and (optionally) your DocumentComposer.",
        ),
      ),
      // ParagraphNode(
      //   id: Editor.createNodeId(),
      //   text: AttributedText(
      //     "Now, you're off to the races! SuperEditor renders your document, and lets you select, insert, and delete content.",
      //   ),
      // ),
      // ParagraphNode(
      //   id: Editor.createNodeId(),
      //   text: AttributedText('Explore the toolkit 🔎'),
      //   metadata: {
      //     'blockType': header2Attribution,
      //   },
      // ),
      // ListItemNode.unordered(
      //   id: Editor.createNodeId(),
      //   text: AttributedText(
      //     "Use MutableDocument as an in-memory representation of a document.",
      //   ),
      // ),
      // ListItemNode.unordered(
      //   id: Editor.createNodeId(),
      //   text: AttributedText(
      //     "Implement your own document data store by implementing the Document api.",
      //   ),
      // ),
      // ListItemNode.unordered(
      //   id: Editor.createNodeId(),
      //   text: AttributedText(
      //     "Implement your down DocumentLayout to position and size document components however you'd like.",
      //   ),
      // ),
      // ListItemNode.unordered(
      //   id: Editor.createNodeId(),
      //   text: AttributedText(
      //     "Use SuperSelectableText to paint text with selection boxes and a caret.",
      //   ),
      // ),
      // ListItemNode.unordered(
      //   id: Editor.createNodeId(),
      //   text: AttributedText(
      //     'Use AttributedText to quickly and easily apply metadata spans to a string.',
      //   ),
      // ),
      ...List.generate(
          100,
          (i) => ParagraphNode(
                id: Editor.createNodeId(),
                text: AttributedText(
                  "Dr. James was a renowned scientist who dedicated his entire life to the study of the universe. He spent countless nights gazing at the stars, analyzing celestial patterns, and making groundbreaking discoveries. His work was admired by many, and his theories revolutionized the way people perceived space. However, despite his immense contributions, he often found himself lost in thoughts, questioning the vastness of the cosmos. Was there life beyond Earth? If so, how different would it be from humanity? One evening, as he sat in his observatory, he received a mysterious signal from a distant galaxy. The signal was repetitive, structured, and completely unlike anything he had encountered before. It wasn’t just random noise; it carried a pattern, a message. His heart pounded with excitement. Could this be the first proof of extraterrestrial intelligence? Days turned into weeks as Dr. James and his team worked tirelessly to decode the message. They ran it through countless algorithms, analyzed every possible linguistic structure, and even considered mathematical interpretations. But the answer remained elusive. Then, on a quiet Sunday afternoon, the breakthrough happened. The message was a sequence of prime numbers followed by a set of geometric shapes. This was no accident. It was a deliberate attempt at communication, a universal language that any advanced civilization would understand. The revelation sent shockwaves through the scientific community. Governments, media outlets, and ordinary people around the world were captivated by the news. The discovery meant one thing: humanity was not alone. However, with excitement came fear. What were the intentions of the senders? Were they peaceful explorers, or did they see Earth as an opportunity to conquer? Dr. James knew that finding the answer would take years, perhaps even decades. But one thing was certain—history had changed forever.",
                ),
              ))
    ],
  );
}
