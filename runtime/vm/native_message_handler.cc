// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include "vm/native_message_handler.h"

#include <memory>

#include "vm/dart_api_message.h"
#include "vm/isolate.h"
#include "vm/message.h"
#include "vm/message_snapshot.h"
#include "vm/snapshot.h"

namespace dart {

NativeMessageHandler::NativeMessageHandler(const char* name,
                                           Dart_NativeMessageHandler func)
    : name_(Utils::StrDup(name)), func_(func) {}

NativeMessageHandler::~NativeMessageHandler() {
  free(name_);
}

#if defined(DEBUG)
void NativeMessageHandler::CheckAccess() {
  ASSERT(Isolate::Current() == nullptr);
}
#endif

MessageHandler::MessageStatus NativeMessageHandler::HandleMessage(
    std::unique_ptr<Message> message) {
  if (message->IsOOB()) {
    // We currently do not use OOB messages for native ports.
    UNREACHABLE();
  }
  // We create a native scope for handling the message.
  // All allocation of objects for decoding the message is done in the
  // zone associated with this scope.
  ApiNativeScope scope;
  Dart_CObject* object = ReadApiMessage(scope.zone(), message.get());
  (*func())(message->dest_port(), object);
  return kOK;
}

}  // namespace dart
