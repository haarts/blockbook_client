import 'package:blockbook/blockbook.dart';

main() {
  var client = Blockbook("https://btc1.trezor.io");
  print('awesome: ${client.status()}');
}
