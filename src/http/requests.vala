public class Request: GLib.Object { 

    private string url = "https://free.currencyconverterapi.com/api/v6/convert?q=";

    public void Request() {
        
    }

    public string getUrl(string from, string to) {
        return url + from + "_" + to + "&compact=ultra";
    }

    public void getCurrenyValue(string curreny_id) {	
		stdout.printf ("Getting status");
		// create an HTTP session
		var session = new Soup.Session ();
		var message = new Soup.Message ("GET", getUrl("USD", curreny_id));
	
		// send the HTTP request and wait for response
		session.send_message (message);
	
		// output the XML result to stdout 
		stdout.write (message.response_body.data);
	}

}