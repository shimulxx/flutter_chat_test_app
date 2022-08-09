import 'package:intl/intl.dart';

abstract class AppDateTimeFormatUseCase{
  String curTime();
  String timeFromDateTime({required DateTime dateTime});
}

class AppDateTimeFormatUseCaseImp implements AppDateTimeFormatUseCase{
  final DateFormat dateFormat;

  AppDateTimeFormatUseCaseImp({required this.dateFormat});

  @override
  String curTime() {
    return timeFromDateTime(dateTime: DateTime.now());
  }

  @override
  String timeFromDateTime({required DateTime dateTime}) {
    return dateFormat.format(dateTime);
  }

}