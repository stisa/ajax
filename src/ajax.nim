import dom

##TODO https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequestEventTarget
type ProgressEvent* = object of Event
  size* :int
  loaded* :int

type XmlHttpRequestEventTarget* = object of EventTarget
  ## The folliwing additional event handlers are inherited:
  ## onabort* :proc()
  ## Contains the function to call when a request is aborted and the abort event is received by this object.
  ## onerror* :proc()
  ## Contains the function to call when a request encounters an error and the error event is received by this object.
  ## onload* :proc()
  ## Contains the function to call when an HTTP request returns after successfully fetching content and the load event is received by this object.
  onloadstart* :proc(e:Event)
    ## Contains the function that gets called when the HTTP request first begins loading data and the loadstart event is received by this object.
  onprogress* :proc(e:ProgressEvent)
    ## Contains the function that is called periodically with information about the progress of the request and the progress event is received by this object.
  ontimeout* :proc(e:Event)
    ## Contains the function that is called if the event times out and the timeout event is received by this object; this only happens if a timeout has been previously established by setting the value of the XMLHttpRequest object's timeout attribute.
  onloadend* :proc(e:Event)
    ## Contains the function that is called when the load is completed, even if the request failed, and the loadend event is received by this object.
type XmlHttpRequestUpload* = object of XmlHttpRequestEventTarget

type ReadyState* = enum
  rsUNSENT = 0 # Client has been created. open() not called yet.
  rsOPENED = 1 # open() has been called.
  rsHEADERS_RECEIVED = 2 # send() has been called, and headers and status are available.
  rsLOADING = 3 # Downloading; responseText holds partial data.
  rsDONE = 4 # The operation is complete.

type XMLHttpRequestObj  {.importc} = object of RootObj
  onreadystatechange* :proc(e:Event)
    ## An EventHandler that is called whenever the readyState attribute changes.
  readyState* :ReadyState
    ## Returns an unsigned short, the state of the request.
  response* :cstring # this is... a problem. Maybe move to a proc so the object is not generice'd?' https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/response
    ## Returns an ArrayBuffer, Blob, Document, JavaScript object, or a DOMString, depending on the value of XMLHttpRequest.responseType. that contains the response entity body.
  responseText* :cstring
    ## Returns a DOMString that contains the response to the request as text, or null if the request was unsuccessful or has not yet been sent.
  responseType* : cstring #TODO: enum?
    ## Is an enumerated value that defines the response type.
  responseURL* :cstring
    ## Returns the serialized URL of the response or the empty string if the URL is null.
  responseXML* :Document
    ## Returns a Document containing the response to the request, or null if the request was unsuccessful, has not yet been sent, or cannot be parsed as XML or HTML.
    ## Not available to workers
  status* :int
    ## Returns an unsigned short with the status of the response of the request. (see https://developer.mozilla.org/en-US/docs/Web/HTTP/Response_codes )
  statusText* :cstring
    ## Returns a DOMString containing the response string returned by the HTTP server. Unlike XMLHTTPRequest.status, this includes the entire text of the response message ("200 OK", for example).
    ## Per HTTP/2 specification (8.1.2.4 Response Pseudo-Header Fields), HTTP/2 does not define a way to carry the version or reason phrase that is included in an HTTP/1.1 status line.
  timeout* :int
    ## Is an unsigned long representing the number of milliseconds a request can take before automatically being terminated.
  ontimeout* :proc(e:Event)
    ## Is an EventHandler that is called whenever the request times out.
  withCredentials* :bool
    ##Is a Boolean that indicates whether or not cross-site Access-Control requests should be made using credentials such as cookies or authorization headers.
  upload* :XmlHttpRequestUpload #TODO
    ## Is an XMLHttpRequestUpload, representing the upload process.
  
type XMLHttpRequest= ref XMLHttpRequestObj

proc  newXMLHttpRequest*():XMLHttpRequest {.importcpp: "new XMLHttpRequest()"}
  # Create a new xmlhttprequest object. No support for custom parameters for now.

proc abort*(r:XMLHttpRequest){.importcpp.}
  ## Aborts the request if it has already been sent.
proc getAllResponseHeaders*(r:XMLHttpRequest) :cstring {.importcpp.}
  ## Returns all the response headers, separated by CRLF, as a string, or null if no response has been received.
proc getResponseHeader*(r:XMLHttpRequest,name:cstring):cstring{.importcpp.}
  ## Returns the string containing the text of the specified header, or null if either the response has not yet been received or the header doesn't exist in the response.
proc open*(r:XMLHttpRequest, methd:cstring, url:cstring, async:bool=true, user:cstring=nil, password:cstring=nil){.importcpp.}
  ## Initializes a request. This method is to be used from JavaScript code; to initialize a request from native code, use openRequest() instead.
proc overrideMimeType*(r:XMLHttpRequest, mime :cstring){.importcpp.}
  ## Overrides the MIME type returned by the server.
proc send*(r:XMLHttpRequest){.importcpp.}
proc send*(r:XMLHttpRequest,data:cstring|Document){.importcpp.}
  ## Sends the request. If the request is asynchronous (which is the default), this method returns as soon as the request is sent.
proc setRequestHeader*(r:XMLHttpRequest,header,value:cstring){.importcpp.}
  ##Sets the value of an HTTP request header. You must call setRequestHeader()after open(), but before send().