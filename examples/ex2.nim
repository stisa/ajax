import dom
import ../src/ajax

proc makeRequest(url:cstring) =
  var httpRequest = newXMLHttpRequest()

  httpRequest.open("POST", url)
  # httpRequest.setRequestHeader("Content-Type", "appliction/json")
  httpRequest.send("{name:\"hi\"}".cstring);

document.getElementById("ajaxButton").onclick = proc(e:Event) =
  makeRequest("test.html")