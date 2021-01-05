
class DateUtil{

  var months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String buildDate(String date){

    try{
      var datetime = DateTime.parse(date);
      return "${datetime.day} de ${months[datetime.month-1]} de ${datetime.year} às ${datetime.hour}:${datetime.minute}";
    }catch(e){
      return "";
    }

  }

}