public class Application : Gtk.Window {
	public Application (Array<CurrencyModel> currencies) {
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


		var list = new List<CurrencyModel> ();
		var one_currency = new CurrencyModel();
		one_currency.country_code = "TR";
		one_currency.currenc_id = "TRY";
		one_currency.currency_name = "Turkish Lira";
		one_currency.currency_symbol = "₺";
		one_currency.currency_value = 5.4654;
		one_currency.calculated_value = 5.46;

		list.append(one_currency);


		var second_currency = new CurrencyModel();
		second_currency.country_code = "US";
		second_currency.currenc_id = "USD";
		second_currency.currency_name = "United States Dolar";
		second_currency.currency_symbol = "$";
		second_currency.currency_value = 1;
		second_currency.calculated_value = 1;

		list.append(second_currency);


		var third_currency = new CurrencyModel();
		third_currency.country_code = "EU";
		third_currency.currenc_id = "EUR";
		third_currency.currency_name = "Euro";
		third_currency.currency_symbol = "€";
		third_currency.currency_value = 0.882;
		third_currency.calculated_value = 651.5785;

		list.append(third_currency);

		list.append(one_currency);
		list.append(second_currency);
		list.append(third_currency);
		list.append(one_currency);

		currencyMainList.LoadList(currencies);

		// The Box:
		Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
		box.pack_start (headerBar, false, false, 0);
		box.pack_start (currencyMainList, true, true, 0);
		//box.pack_start (Items(), false, false, 0);
		this.add (box);
	}






	public static int main (string[] args) {


		var currencyData = new CurrencyData();
		currencyData.load();

		var database = new Database();
		database.open();
		//  database.setCurrency("TRY", 5.45);
		database.getCurrency("TRY");

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

        warning ("aa ");


		Application app = new Application (currencyData.currencies);
		app.show_all ();
		Gtk.main ();



		return 0;
	}
	
}
