import 'package:flutter/material.dart';

enum SwapStatus {
  accepted('accepted', 1, Icons.check, Colors.green),
  pending('pending', 2, Icons.access_time, Colors.yellow),
  rejected('rejected', 3, Icons.cancel, Colors.red),
  cancelled('cancelled', 4, Icons.clear, Colors.grey);

  final String name;
  final int value;
  final IconData icon;
  final Color color;

  const SwapStatus(this.name, this.value, this.icon, this.color);

  static Icon getIconWithColorByName(String statusName) {
    for (var status in SwapStatus.values) {
      if (status.name.toLowerCase() == statusName.toLowerCase()) {
        return Icon(status.icon, color: status.color);
      }
    }
    return const Icon(Icons.help, color: Colors.black);
  }
}
