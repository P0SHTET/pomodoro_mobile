import 'package:dio/dio.dart';
import 'package:pomodoro_mobile/dto/pomodoro_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET('pomodorolist/')
  Future<List<PomodoroDto>> getList();

  @POST('pomodorolist/')
  Future<void> addPomodoro(@Body() PomodoroDto dto);

  @DELETE('pomodorolist/{id}/')
  Future<void> removePomodoro(@Path('id') String id);

  @PATCH('pomodorolist/{id}/')
  Future<void> updatePomodoro(@Path('id') String id, @Body() PomodoroDto dto);
}
