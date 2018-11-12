public class Requests: GLib.Object { 

    private string url = "https://free.currencyconverterapi.com/api/v6/convert?q=";

    public void Requests() {
        
    }

    public string getUrl(string from, string to) {
        return url + from + "_" + to + "&compact=ultra";
    }

    public double getCurrenyValue(string currency_id) {	

		double value = 1.0;

		stdout.printf ("Getting status");
		// create an HTTP session
		var session = new Soup.Session ();
		var message = new Soup.Message ("GET", getUrl("USD", currency_id));
	
		// send the HTTP request and wait for response
		session.send_message (message);
	
		// output the XML result to stdout 
		stdout.write (message.response_body.data);


        try {
            var parser = new Json.Parser ();
            parser.load_from_data ( (string) message.response_body.data, -1);
    
            var root_object = parser.get_root ().get_object ();
			var result = root_object.get_double_member("USD_" + currency_id);
			
			value = result;
           
        } catch (Error e) {
            warning("vvv");
            stderr.printf ("I guess something is not working...\n");
        }

		return value;
	}

}