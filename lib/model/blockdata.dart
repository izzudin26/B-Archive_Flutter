class Metadata {
  String receiverName;
  String receiverNumber;
  String transactionDate;
  String referenceNumber;
  String transactionType;
  int amount;
  String note;
  String imageUri;

  Metadata(
      {required this.receiverName,
      required this.receiverNumber,
      required this.transactionDate,
      required this.referenceNumber,
      required this.amount,
      required this.note,
      required this.imageUri,
      required this.transactionType});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
        receiverName: json["receiverName"],
        receiverNumber: json["receiverNumber"],
        transactionDate: json["transactionDate"],
        referenceNumber: json["referenceNumber"],
        amount: json["amount"],
        note: json["note"],
        imageUri: json["imageUri"],
        transactionType: json["transactionType"]);
  }

  Map<String, dynamic> toJson() => {
        "receiverName": receiverName,
        "receiverNumber": receiverNumber,
        "transactionDate": transactionDate,
        "transactionType": transactionType,
        "referenceNumber": referenceNumber,
        "amount": amount,
        "note": note,
        "imageUri": imageUri
      };
}

class Blockdata {
  Metadata metadata;
  int timestamp;
  int iteration;
  String hash;

  Blockdata(
      {required this.metadata,
      required this.timestamp,
      required this.iteration,
      required this.hash});

  factory Blockdata.fromJson(Map<String, dynamic> json) {
    return Blockdata(
        metadata: Metadata.fromJson(json["metdata"]),
        timestamp: json["timestamp"],
        iteration: json["iteration"],
        hash: json["hash"]);
  }
}
