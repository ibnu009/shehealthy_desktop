class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  List<String> expandedValue;
  String headerValue;
  bool isExpanded;
}