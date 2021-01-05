import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//Class responsible for making connections with API
class Api{

  final String urlBase;

  Api(this.urlBase);

  /// Method that executes the connection call of the GET type
  /// @params uri
  /// @params headers (optional)
  Future <dynamic> get(String uri, {Map<String,String> headers}) async{

    try{

      http.Response response = await http.get(urlBase+uri, headers: headers);

      final statusCode = response.statusCode;
      final String jsonBody = response.body;

      if(statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException("Error request:",statusCode);
      }

      const JsonDecoder decoder = const JsonDecoder();
      return decoder.convert(response.body);

    } on Exception catch(e){
      throw new FetchDataException(e.toString(),0);
    }

  }

  /// Method that executes the connection type POST
  /// @params uri
  /// @params body
  /// @params headers (optional)
  Future <dynamic> post(String uri,dynamic body, {Map<String,String> headers}) async{

    try{

      http.Response response = await http.post(urlBase+uri, body: body, headers:headers);

      final statusCode = response.statusCode;

      if(statusCode < 200 || statusCode >= 300) {
        throw new FetchDataException("Error request:",statusCode);
      }

      const JsonDecoder decoder = const JsonDecoder();
      return decoder.convert(response.body);

    } on Exception catch(e){
      throw new FetchDataException(e.toString(),0);
    }

  }

  /// Method that executes the connection call of the PUT type
  /// @params uri
  /// @params body
  /// @params headers (optional)
  Future <dynamic> put(String uri,dynamic body, {Map<String,String> headers}) async{

    try{

      http.Response response = await http.put(urlBase+uri, body: body, headers:headers);

      final statusCode = response.statusCode;

      if(statusCode < 200 || statusCode >= 300) {
        throw new FetchDataException("Error request:",statusCode);
      }

      const JsonDecoder decoder = const JsonDecoder();
      return decoder.convert(response.body);

    } on Exception catch(e){
      throw new FetchDataException(e.toString(),0);
    }

  }

  /// Method that executes the connection call of the DELETE type
  /// @params uri
  /// @params headers (optional)
  Future <dynamic> delete(String uri, {Map<String,String> headers}) async{

    try{

      http.Response response = await http.delete(urlBase+uri, headers:headers);

      final statusCode = response.statusCode;

      if(statusCode < 200 || statusCode >= 300) {
        throw new FetchDataException("Error request:",statusCode);
      }

      const JsonDecoder decoder = const JsonDecoder();
      return decoder.convert(response.body);

    } on Exception catch(e){
      throw new FetchDataException(e.toString(),0);
    }

  }

}

class FetchDataException implements Exception {
  String _message;
  int _code;

  FetchDataException(this._message,this._code);

  String toString() {
    return "Exception: $_message/$_code";
  }

  int code(){
    return _code;
  }
}