import 'dart:io';
import 'dart:math';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

class Blockbook extends BaseClient {
  static const String _statusPath = '/api/';
  static const String _blockHashPath = '/api/v2/block-index/';
  static const String _transactionPath = '/api/v2/tx/';
  static const String _transactionSpecificPath = '/api/v2/tx-specific/';
  static const String _addressPath = '/api/v2/address/';
  static const String _xpubPath = '/api/v2/xpub/';
  static const String _utxoPath = '/api/v2/utxo/';
  static const String _blockPath = '/api/v2/block/';
  static const String _sendTransactionPath = '/api/v2/sendtx';

  static const String _userAgent = 'Blockbook - Dart';
  static const String _contentType = 'application/json';

  final Uri restUrl;
  final Uri websocketUrl;
  final Client _client;

  Blockbook(String restUrl, String websocketUrl)
      : this.restUrl = Uri.parse(restUrl),
        this.websocketUrl = Uri.parse(websocketUrl),
        this._client = Client();

  Future<StreamedResponse> send(BaseRequest request) {
    request.headers[HttpHeaders.userAgentHeader] = _userAgent;
    request.headers[HttpHeaders.contentTypeHeader] = _contentType;

    return _client.send(request);
  }

  Future<Map<String, dynamic>> status() async {
    var response = await get(restUrl.replace(path: _statusPath));

    return json.decode(response.body);
  }

  Future<String> blockHash(int height) async {
    var response = await get(restUrl.replace(path: "$_blockHashPath$height"));

    return json.decode(response.body)["blockHash"];
  }

  Future<Map<String, dynamic>> transaction(String txId) async {
    var response = await get(restUrl.replace(path: "$_transactionPath$txId"));

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> transactionSpecific(String txId) async {
    var response =
        await get(restUrl.replace(path: "$_transactionSpecificPath$txId"));

    return json.decode(response.body);
  }

  // TODO add query parameters
  Future<Map<String, dynamic>> address(String address) async {
    var response = await get(restUrl.replace(path: "$_addressPath$address"));

    return json.decode(response.body);
  }

  // TODO add query parameters
  Future<Map<String, dynamic>> xpub(String xpub) async {
    var response = await get(restUrl.replace(path: "$_xpubPath$xpub"));

    return json.decode(response.body);
  }

  Future<List<dynamic>> utxo(String addressOrXpub) async {
    var response = await get(restUrl.replace(path: "$_utxoPath$addressOrXpub"));

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> block(dynamic hashOrHeight) async {
    var response = await get(restUrl.replace(path: "$_blockPath$hashOrHeight"));

    return json.decode(response.body);
  }

  Stream getInfo() {
    var channel = IOWebSocketChannel.connect(websocketUrl);
    channel.sink.add('{"method": "getInfo"}');

    return channel.stream.map((message) => json.decode(message));
  }

  Stream subscribeAddresses(List<String> addresses) {
    var channel = IOWebSocketChannel.connect(websocketUrl);
    var request = {
      "id": Random().nextInt(1000).toString(),
      "method": "subscribeAddresses",
      "params": {
        "addresses": addresses,
      },
    };

    channel.sink.add(json.encode(request));

    return channel.stream.map((message) => json.decode(message));
  }
}
