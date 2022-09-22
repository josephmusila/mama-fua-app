import 'package:http/http.dart' as http;

main() {
  sendData();
}

void sendData() async {
  var url = Uri.parse("http://127.0.0.1:8000/api/workerRequest/");
  var response = await http.post(url,
      body: {"user": "josemusila03@gmail.com", "work_description": "working from app"});

  print(response.body);
}
