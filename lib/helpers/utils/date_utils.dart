class CustomDateUtils {
  String addZeroInMinute(int minute) {
    String result = minute.toString();

    if (minute == 0) {
      result = '00';
    } else if (minute < 10) {
      result = '0$minute';
    }

    return result;
  }

  String addZeroInHour(int hour) {
    String result = hour.toString();

    if (hour == 0) {
      result = '00';
    } else if (hour < 10) {
      result = '0$hour';
    }

    return result;
  }

  int countDayInMonth(int numberMonth, int year) {
    var result = 31;

    switch (numberMonth) {
      case 2:
        if (year % 4 == 0) {
          result = 29;
        }
        result = 28;
      case 3:
        result = 31;
      case 4:
        result = 30;
      case 5:
        result = 31;
      case 6:
        result = 30;
      case 7:
        result = 31;
      case 8:
        result = 31;
      case 9:
        result = 30;
      case 10:
        result = 31;
      case 11:
        result = 30;
      case 12:
        result = 31;
      default:
        result = 31;
    }

    return result;
  }

  String dateForFiltere(DateTime date) {
    String result = numberMonthToString(date.month);
    result += ' ${date.day} ${date.year}';

    return result;
  }

  String numberMonthToString(int numberMonth) {
    var result = 'Jan';

    switch (numberMonth) {
      case 2:
        result = 'Feb';
      case 3:
        result = 'Mar';
      case 4:
        result = 'Apr';
      case 5:
        result = 'May';
      case 6:
        result = 'June';
      case 7:
        result = 'July';
      case 8:
        result = 'Aug';
      case 9:
        result = 'Sep';
      case 10:
        result = 'Oct';
      case 11:
        result = 'Nov';
      case 12:
        result = 'Dec';
      default:
        result = 'Jan';
    }

    return result;
  }

  String convertDateInJournal(DateTime date) {
    var stringMonth = numberMonthToString(date.month);
    return 'Месяц $stringMonth ${date.year}';
  }

  String convertDateInDatePicker(DateTime date) {
    var stringMonth = numberMonthToString(date.month);
    return '${date.day} $stringMonth ${date.year}';
  }
}
