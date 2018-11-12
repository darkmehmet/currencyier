public class CurrencyModel: GLib.Object { 
    public string country_code;
    public string currenc_id;
    public string currency_name;
    public string currency_symbol;
    public double currency_value;
    public double calculated_value;

    public void CurrencyListModel() {
        country_code = "";
        currenc_id = "";
        currency_name = "";
        currency_symbol = "";
        currency_value = 0.0;
        calculated_value = 0.0;
    }
}