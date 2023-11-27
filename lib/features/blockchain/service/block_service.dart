// import 'dart:convert';

// import 'package:aquaniti/secrets.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:web3dart/web3dart.dart';

// class BlockChainService {
//   Future<Web3Client> connectToEthereum() async {
//     final client = Web3Client(
//         "https://polygonzkevm-testnet.g.alchemy.com/v2/KdbPrWfSkagJsBPhx0KyXLHqI77aJ5JQ",
//         Client());
//     return client;
//   }

//   Future<DeployedContract> loadContract(
//       Web3Client client, BuildContext context) async {
//     var data = await DefaultAssetBundle.of(context)
//         .loadString('assets/data/aquanity.json');
//     final contractAddress =
//         EthereumAddress.fromHex("0xcca3d3016cd14fcd2ca1b8ac9f8d19da28e08a95");
//     final contractAbi = jsonDecode(data);

//     return DeployedContract(
//         ContractAbi.fromJson(contractAbi, "aquaniti"), contractAddress);
//   }

//   Future<void> callSmartContractFunction(
//       Web3Client client, DeployedContract contract) async {
//     final credentials = EthPrivateKey.fromHex(Secrets.privateKey);
//     final contractInstance =
//         DeployedContract(contract.contract, contract.address);
//   }
// }
