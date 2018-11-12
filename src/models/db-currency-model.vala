public class DBCurrencyModel: GLib.Object { 
    public string currency_id;
    public double currency_value;
    public int last_updated;

    public void DBCurrencyListModel() {
        currency_id = "";
        currency_value = 0.0;
        last_updated = 0;
    }
}