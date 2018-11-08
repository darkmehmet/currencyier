

public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "Currency";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 350);

		this.set_border_width(0);
		//this.decorated = false;

		this.name = "pencere";

		// The Box:
		Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
		box.pack_start (HeaderBar(), false, false, 0);
		box.pack_start (CurrencyList(), true, true, 0);
		//box.pack_start (Items(), false, false, 0);
		this.add (box);
	}

public Gtk.Box HeaderBar() {

	var header = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
	header.name = "headerbar";
	header.height_request = 70;

	var searchBox = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
	
	searchBox.height_request = 35;
	//  searchBox.width_request = 200;

	var search_entry = new Gtk.Entry ();
	search_entry.name = "search_entry";
	search_entry.text = "Search...";
	search_entry.width_request = 250;

	//search_entry.padding = 0;
	

	//  search_entry.get_frame_size(0,0,200,35);

	searchBox.pack_start(search_entry, false, false, 0);


	
	header.pack_start(searchBox, false, false, 0);
	

	header.pack_start(new Gtk.Box (Gtk.Orientation.VERTICAL, 0), false, false, 0);

	return header;
}


public Gtk.ScrolledWindow CurrencyList() {

	Gtk.ScrolledWindow scrolled = new Gtk.ScrolledWindow (null, null);


	var currency_list = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
	currency_list.name = "currency-list";

	for (int i = 0; i < 10; i++) {
		var currency1 = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
		currency1.name = "currency1";
		currency1.name = i % 2 == 1 ? "currency1" : "currency2";
		currency1.height_request = 70;

		var pixbuf = new Gdk.Pixbuf.from_file_at_scale ("./turkey.svg", 32, 32, true);
		

		var currency_image = new Gtk.Image();
		currency_image.set_from_pixbuf(pixbuf);

		var currency_name_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		currency_name_box.height_request = 32;
		currency_name_box.name = "currency_name_box";
		var currency_short_label = new Gtk.Label("TRY");
		currency_short_label.name = "currency_short_label";
		currency_short_label.halign = Gtk.Align.START;
		var currency_long_label = new Gtk.Label("Turkish Lira");
		currency_long_label.name = "currency_long_label";
		currency_long_label.halign = Gtk.Align.START;

		currency_name_box.pack_start(currency_short_label, false, false);
		currency_name_box.pack_start(currency_long_label, false, false);

		var currency_value_label = new Gtk.Label("₺5.45");
		currency_value_label.name = "currency_value_label";
		currency_value_label.halign = Gtk.Align.END;


		currency1.pack_start(currency_image, false, false, 0);
		currency1.pack_start(currency_name_box, false, false, 0);
		currency1.pack_start(currency_value_label, true, true, 0);


		
		currency_list.pack_start(currency1, false, false, 0);
	

	}
	
	scrolled.add(currency_list);

	return scrolled;
}



	public static int main (string[] args) {
		Gtk.init (ref args);
		
		var css_provider = new Gtk.CssProvider();

		try {
			css_provider.load_from_path("./custom.css");
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
}
