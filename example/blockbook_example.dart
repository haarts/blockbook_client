import 'package:blockbook/blockbook.dart';

main(List<String> args) async {
  var client =
      Blockbook("https://btc1.trezor.io", "wss://btc1.trezor.io/websocket");
  print('status:\n ${await client.status()}');

  Stream txs = client.subscribeAddresses([args[0]]);
  txs = txs.handleError(print);
  await for (var tx in txs) {
    print(tx);
  }
}
