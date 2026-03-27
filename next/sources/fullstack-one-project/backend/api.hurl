GET http://127.0.0.1:8080/
HTTP 200
[Asserts]
body contains "<div id=\"app\"></div>"

GET http://127.0.0.1:8080/frontend.js
HTTP 200
[Asserts]
body contains "function"

POST http://127.0.0.1:8080/submit
Content-Type: application/json
{
  "title": "Write docs"
}
HTTP 200
[Asserts]
jsonpath "$[0]" == "Accepted"
jsonpath "$[1]" == "Write docs"

POST http://127.0.0.1:8080/submit
Content-Type: application/json
{
  "title": "bad #title"
}
HTTP 400
[Asserts]
jsonpath "$[0]" == "ValidationError"
jsonpath "$[1]" == "ForbiddenHash"

POST http://127.0.0.1:8080/submit
Content-Type: application/json
{
  "title": "01234567890123456789012345"
}
HTTP 400
[Asserts]
jsonpath "$[0]" == "ValidationError"
jsonpath "$[1][0]" == "TooLong"
jsonpath "$[1][1]" == 26

POST http://127.0.0.1:8080/submit
Content-Type: application/json
```
{"title":
```
HTTP 400
[Asserts]
jsonpath "$" == "InvalidJson"
