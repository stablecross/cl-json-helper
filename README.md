###cl-json-helper:  A Common Lisp library to assist cl-json.

cl-json encodes and decodes JSON data.  cl-json-helper adds two functions to help encoding
JSON data and one function to help in processing decoded JSON data.

The nickname **xjson** can be used for the **cl-json-helper** package.

[Function]<br>
**json-empty** ()

		The return value is decoded by cl-json as {}.
		
		Example:
			(cl-json:encode-json-to-string `(("Empty" . ,(xjson:json-empty))))
		=> "{\"Empty\":{}}"
		

[Function]<br>
**json-bool** (val)

		Encodes val as "true" or "false"
	
		Examples:
			(cl-json:encode-json-to-string `(("TRUE" . ,(xjson:json-bool t))))
		=> "{\"TRUE\":true}"
			(cl-json:encode-json-to-string `(("FALSE" . ,(xjson:json-bool nil))))
		=> "{\"FALSE\":false}"

[Function]<br>
**json-key-value** (key list &key (test #'eql))

		Return the value associated with _key_ in a decoded JSON list, if present, and whether
		or not _key_ was found.
		
		(cl-json:encode-json-to-string '(("HELLO" . "WORLD")
					  					("ITS" . "ME")
					  					("CEST" . "MOI")))
		=> "{\"HELLO\":\"WORLD\",\"ITS\":\"ME\",\"CEST\":\"MOI\"}"
		
		(cl-json:decode-json-from-string "{\"HELLO\":\"WORLD\",\"ITS\":\"ME\",\"CEST\":\"MOI\"}")
		=> ((:+HELLO+ . "WORLD") (:+ITS+ . "ME") (:+CEST+ . "MOI"))
		
		(xjson:json-key-value :+CEST+ '((:+HELLO+ . "WORLD") (:+ITS+ . "ME") (:+CEST+ . "MOI")))
		=> "MOI"
		   T
		
		(xjson:json-key-value :+FALSE+ (cl-json:decode-json-from-string "{\"FALSE\":false}"))
		=> NIL
		   T
		
		(xjson:json-key-value :+BAR+ (cl-json:decode-json-from-string "{\"FALSE\":false}"))
		=> NIL
		   NIL
		  
**json-key-value** is just a glorified call to Lisp's **assoc** 
		
####License
cl-json-helper is available under a BSD-like license.  See the file LICENSE for
details.

#### Contact
For any questions or comments, please feel free to email me, Bob Felts
<wrf3@stablecross.com>
