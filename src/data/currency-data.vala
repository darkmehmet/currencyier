public class CurrencyData { 

    public void CurrencyData() {}

    public Array<CurrencyModel> currencies;

    public CurrencyModel getCurrency(string currency_id) {
        var currency = new CurrencyModel();
        for(int i = 0; i < currencies.length; i++) {
            if(currencies.index(i).currency_id ==  currency_id ) {
                currency = currencies.index(i);
            }
        }
        return currency;
    }

    public void load(){
        // Glib.Array
        currencies = new Array<CurrencyModel> ();
        var jsonTxt = readJsonFile();


        try {
            var parser = new Json.Parser ();
            parser.load_from_data (jsonTxt, -1);
    
            var root_object = parser.get_root ().get_object ();
            var currencies_array = root_object.get_array_member ("currencies");
            var currencies_length = currencies_array.get_length();

            for (int i = 0; i < currencies_length; i++) {
                var one_currency = currencies_array.get_object_element(i);

                var currencyModel =  new CurrencyModel();

                currencyModel.country_code = one_currency. get_string_member("id");
                currencyModel.currency_id = one_currency. get_string_member("currencyId");
                currencyModel.currency_name = one_currency. get_string_member("currencyName");
                currencyModel.currency_symbol = one_currency. get_string_member("currencySymbol");

                currencies.append_val(currencyModel);
                 
            }

            warning("lll");
        } catch (Error e) {
            warning("vvv");
            stderr.printf ("I guess something is not working...\n");
        }

    }

    private string readJsonFile() {
        var result = "";
        // A reference to our file

        var file = File.new_for_path ("src/data/currencies.json");

        if (!file.query_exists ()) {
            //error ("File '%s' doesn't exist.\n", file.get_path ());
            return "hata";
        }

        try {
            // Open file for reading and wrap returned FileInputStream into a
            // DataInputStream, so we can read line by line

            var dis = new DataInputStream (file.read ());
            string line;

            // Read lines until end of file (null) is reached
            while ((line = dis.read_line (null)) != null) {
                result = result + line;
            }
        } catch (Error e) {
            error ("%s", e.message);
        }

        return result;
    }
}