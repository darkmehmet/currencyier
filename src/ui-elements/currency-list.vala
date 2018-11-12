public class CurrencyMainList : Gtk.ScrolledWindow { 
    public CurrencyMainList() {

    }



    public void LoadList(Array<CurrencyModel> currencies) {


        var currency_list = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
        currency_list.name = "currency-list";

        var count = 0;

        for (int i = 0; i < currencies.length ; i++) {
        
            var currency = currencies.index(i);

            var currency1 = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
            currency1.name = count % 2 == 0 ? "currency1" : "currency2";
            currency1.height_request = 70;

            var currency_image = new Gtk.Image();
            currency_image.name = "currency_image";


            try {

                var pixbuf = new Gdk.Pixbuf.from_file_at_scale (
                    "./src/assets/flags-round-codes/" + currency.country_code +".svg", 32, 32, true
                );
                
                currency_image.set_from_pixbuf(pixbuf);

            } catch (GLib.Error e) {}
        

            var currency_name_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            currency_name_box.height_request = 32;
            currency_name_box.name = "currency_name_box";
            var currency_short_label = new Gtk.Label(currency.currenc_id);
            currency_short_label.name = "currency_short_label";
            currency_short_label.halign = Gtk.Align.START;

            var currency_name = currency.currency_name.length >= 21 ?
                currency.currency_name[0:19] + "..." :
                currency.currency_name;

            var currency_long_label = new Gtk.Label(currency_name);
            currency_long_label.name = "currency_long_label";
            currency_long_label.halign = Gtk.Align.START;

            currency_name_box.pack_start(currency_short_label, false, false);
            currency_name_box.pack_start(currency_long_label, false, false);

            // Converting Double to str
            char[] buf = new char[5]; // count of numbers
            unowned string value = (currency.calculated_value).to_str (buf);

            var currency_value = currency.currency_symbol != null ? 
                currency.currency_symbol + value : value;

            var currency_value_label = new Gtk.Label(currency_value);
            currency_value_label.name = "currency_value_label";
            currency_value_label.halign = Gtk.Align.END;


            currency1.pack_start(currency_image, false, false, 0);
            currency1.pack_start(currency_name_box, false, false, 0);
            currency1.pack_start(currency_value_label, true, true, 0);


            
            currency_list.pack_start(currency1, false, false, 0);
        
            count++;

        };

                
        this.add(currency_list);



            
        
    }

}