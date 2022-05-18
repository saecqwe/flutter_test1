class Reservations{
  int table_id;
  String reservedDate;
  String reservedHour;

  Reservations({required this.reservedDate , required this.reservedHour , required this.table_id});


   @override
  String toString() {
    return 'Table: {table_id: ${table_id}, date: ${reservedDate}, hour: ${reservedHour}}';
  }
}