Ajax
----

Beginning of a wrapper for ajax, for the javascript backend of [nim](https://nim-lang.org)
  
[Examples](http://stisa.space/ajax)  

[Generated Docs](http://stisa.space/ajax/ajax.html)

```nim
import dom
import ajax

proc makeRequest(url:cstring) =
  var httpRequest = newXMLHttpRequest()

  if httpRequest.isNil:
    window.alert("Giving up :( Cannot create an XMLHTTP instance")
    return
  proc alertContents(e:Event) =
    if httpRequest.readyState == rsDONE:
      if httpRequest.status == 200:
        window.alert(httpRequest.responseText)
      else:
        window.alert("There was a problem with the request.")
  httpRequest.onreadystatechange = alertContents
  httpRequest.open("GET", url);
  httpRequest.send();

document.getElementById("ajaxButton").onclick = proc(e:Event) =
  makeRequest("test.html")
```

