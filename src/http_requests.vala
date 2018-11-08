using Soup;

public class Requests { 
    public Requests() {
    
        
    }

    public void aaa() {
        warning("aaa");

        // format the URL to use the username as the filename
        string url = "https://free.currencyconverterapi.com/api/v6/convert?q=USD_TRY&compact=ultra";
    
        stdout.printf ("Getting status");
    
        // create an HTTP session to twitter
        var session = new Soup.Session ();
        var message = new Soup.Message ("GET", url);
    
        // send the HTTP request and wait for response
        session.send_message (message);
    
        // output the XML result to stdout 
        warning ((string) message.response_body.data);
    }
}