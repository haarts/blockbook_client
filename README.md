# Blockbook library

[![pub package](https://img.shields.io/pub/v/bity.svg)](https://pub.dev/packages/blockbook)

A library for communicating with the [Blockbook API]. Some calls are missing.

## Usage

A simple usage example:

```dart
import 'package:blockbook/blockbook.dart';

main() {
  var client = new Blockbook();
}
```

## Installing

Add it to your `pubspec.yaml`:

```
dependencies:
  bity: any
```

## Licence overview

All files in this repository fall under the license specified in 
[COPYING](COPYING). The project is licensed as [AGPL with a lesser clause](https://www.gnu.org/licenses/agpl-3.0.en.html). 
It may be used within a proprietary project, but the core library and any 
changes to it must be published online. Source code for this library must 
always remain free for everybody to access.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/inapay/blockbook_client/issues
[Blockbook API]: https://github.com/trezor/blockbook/blob/master/docs/api.md
