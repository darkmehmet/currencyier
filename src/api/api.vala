public class Api { 

    private Database database;
    private CurrencyData currencyData;
    private Requests requests;

    public void Api() {
    }

    public void load() {
        database = new Database();
        currencyData = new CurrencyData();
        requests = new Requests();
    }

    public Array<CurrencyModel> getSelectedCurrencies() {
        var selected_currencies = new Array<CurrencyModel>();
        Array<string> selected_ids = database.getSelectedCurrencies();
        for (int i = 0; i < selected_ids.length; i++) {
            var one_selected = currencyData.getCurrency(selected_ids.index(i));
            double value = getCurrencyValue(one_selected.currency_id);
            one_selected.currency_value = value;
            selected_currencies.append_val(one_selected);
        }

    }

    public double getCurrencyValue(string currency_id) {
        DBCurrencyModel dbCurrencyModel = database.getCurrencyValue(currency_id);
        if (
            dbCurrencyModel.currency_value == 0.0 ||
            getDate() - dbCurrencyModel.last_updated >= 3600
        ) {
            var new_value = requests.getCurrencyValue(currency_id);
            database.setCurrency(currency_id, new_value);
            return new_value;
        } else {
            return dbCurrencyModel.currency_value;
        }
    }

    public int getDate() {
        var dateTime =DateTime.now();
        return dateTime.to_unix();
    }




}