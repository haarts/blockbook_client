import 'package:blockbook/blockbook.dart';

//ignore_for_file: avoid_print

Future<void> main(List<String> args) async {
  var client =
      Blockbook('https://btc1.trezor.io', 'wss://btc1.trezor.io/websocket');
  print('status:\n ${await client.status()}');

  var txs = client.subscribeAddresses([args[0]]);
  txs = txs.handleError(print);
  await txs.forEach(print);
}
