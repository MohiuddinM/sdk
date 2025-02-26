// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'call_hierarchy_test.dart' as call_hierarchy;
import 'document_color_test.dart' as document_color;
import 'document_highlights_test.dart' as document_highlights;
import 'format_test.dart' as format;
import 'hover_test.dart' as hover;

void main() {
  defineReflectiveSuite(() {
    call_hierarchy.main();
    document_color.main;
    document_highlights.main();
    format.main();
    hover.main();
  }, name: 'lsp_over_legacy');
}
