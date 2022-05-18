class TableModel {
  int id;
  String reservedDate;
  String reservedHour;
  

  TableModel(
      {required this.id,
      required this.reservedDate,
      required this.reservedHour});


      @override
  String toString() {
    return 'Table: {id: ${id}, date: ${reservedDate}, hour: ${reservedHour}}';
  }
}
