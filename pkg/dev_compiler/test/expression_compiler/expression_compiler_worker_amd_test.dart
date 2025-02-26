// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dev_compiler/dev_compiler.dart';
import 'package:test/test.dart';

import 'expression_compiler_worker_shared.dart';
import 'setup_compiler_options.dart';

void main(List<String> args) async {
  // Set to true to enable debug output
  var debug = false;

  group('amd module format -', () {
    for (var soundNullSafety in [true, false]) {
      group('${soundNullSafety ? "sound" : "unsound"} null safety -', () {
        var setup = SetupCompilerOptions(
          moduleFormat: ModuleFormat.amd,
          soundNullSafety: soundNullSafety,
          args: args,
        );
        runTests(setup, verbose: debug);
      });
    }
  });
}
