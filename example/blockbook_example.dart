import 'package:blockbook/blockbook.dart';

main() {
  var client = Blockbook();
  print('awesome: ${client.status()}');
}
