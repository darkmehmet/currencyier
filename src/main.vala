

public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "Currencyier";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 350);

		this.set_border_width(0);
		//this.decorated = false;

		this.name = "pencere";

		HeaderBar headerBar = new HeaderBar();
		CurrencyMainList currencyMainList = new CurrencyMainList();
		currencyMainList.LoadList();
		// The Box:
		Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
		box.pack_start (headerBar, false, false, 0);
		box.pack_start (currencyMainList, true, true, 0);
		//box.pack_start (Items(), false, false, 0);
		this.add (box);
	}






	public static int main (string[] args) {
		Gtk.init (ref args);
		
		var css_provider = new Gtk.CssProvider();

		try {
			css_provider.load_from_path("./src/styles/style.css");
		} catch (GLib.Error e) {warning("sitil yuklenemdi");}

		Gtk.StyleContext.add_provider_for_screen(
			Gdk.Screen.get_default(),
			css_provider,
			Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
		);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();



		return 0;
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
		stdout.write (message.response_body.data);
	}
	
}
