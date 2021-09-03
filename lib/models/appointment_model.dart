class Appointmentmodel {
  int id;
  String loggedBy;
  bool approved;
  String description;
  String date ;
  String? comment;
  String status;

  Appointmentmodel(
    {
      required this.id,
      required this.loggedBy,
      required this.approved,
      required this.description,
      required this.date,
      this.comment,
      required this.status,
    }
  );

  Appointmentmodel? fromJson(Map<String, dynamic> json) {
    id = json["id"];
    loggedBy = json["logged_by"];
    approved = json["approved"];
    description = json["description"];
    date = json["date"];
    comment = json["comment"];
    status = json["status"];
  }
  
  

}
