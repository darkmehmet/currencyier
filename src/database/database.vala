public class Database { 

    private Sqlite.Database db;
    
    public Database() {}

    public int open() {
        
        string errmsg;
    
        // Open a database:
        int ec = Sqlite.Database.open ("test.db", out db);
        if (ec != Sqlite.OK) {
            stderr.printf ("Can't open database: %d: %s\n", db.errcode (), db.errmsg ());
            return -1;
        }
    
        // Insert test data:
        string query = """
            CREATE TABLE currencies (
                currency_id PRIMARY KEY NOT NULL,
                currency_value TEXT NOT NULL,
                last_updated INT NOT NULL
            );

            CREATE TABLE selected_currencies (
                currency_id NOT NULL
            );
            """;
            
        ec = db.exec (query, null, out errmsg);
        if (ec != Sqlite.OK) {
            stderr.printf ("Error: %s\n", errmsg);
            return -1;
        }
    
        return 0;
    }


    public DBCurrencyModel getCurrency(string currency_id) {

        string errmsg;

        Sqlite.Statement stmt;

        var dbCurrency = new DBCurrencyModel();
        dbCurrency.currency_id = currency_id;

        const string prepared_query_str = "SELECT * FROM currencies WHERE currency_id = $CURRENCY_ID;";
        int ec = db.prepare_v2 (prepared_query_str, prepared_query_str.length, out stmt);
        if (ec != Sqlite.OK) {
            stderr.printf ("Error: %d: %s\n", db.errcode (), db.errmsg ());
            return dbCurrency;
        }

        //
        // Use the prepared statement:
        //

        int param_position = stmt.bind_parameter_index ("$CURRENCY_ID");
        assert (param_position > 0);

        stmt._bind_text (param_position, "TRY");


        int cols = stmt.column_count ();
        while (stmt.step () == Sqlite.ROW) {
            for (int i = 0; i < cols; i++) {

                if( stmt.column_name (i) == "currency_value") {
                    var currency_value = double.parse ( stmt.column_text (i) );
                    dbCurrency.currency_value = currency_value;
                }

                if( stmt.column_name (i) == "last_updated") {
                    var last_updated = stmt.column_int (i);
                    dbCurrency.last_updated = last_updated;
                }

            }
        }

        return dbCurrency;

    }

    public int setCurrency(string currency_id, double value) {

        string errmsg;

        string query = "
            INSERT OR REPLACE INTO currencies (currency_id, currency_value, last_updated) 
            VALUES ('" + currency_id +"', '" + value.to_string() + "', 546465);
            ";

        int ec = db.exec (query, null, out errmsg);
        if (ec != Sqlite.OK) {
            stderr.printf ("Error: %s\n", errmsg);
            return -1;
        }

        return 1;

    }


    public Array<string> getSelectedCurrencies() {

        string errmsg;

        Sqlite.Statement stmt;

        var selectedCurrencies = new Array<string>();

        const string prepared_query_str = "SELECT * FROM selected_currencies $DUMB;";
        int ec = db.prepare_v2 (prepared_query_str, prepared_query_str.length, out stmt);
        if (ec != Sqlite.OK) {
            stderr.printf ("Error: %d: %s\n", db.errcode (), db.errmsg ());
            return selectedCurrencies;
        }

        //
        // Use the prepared statement:
        //

        int param_position = stmt.bind_parameter_index ("$DUMB");
        assert (param_position > 0);

        stmt._bind_text (param_position, "");


        int cols = stmt.column_count ();
        while (stmt.step () == Sqlite.ROW) {
            for (int i = 0; i < cols; i++) {

                if( stmt.column_name (i) == "currency_id") {
                    selectedCurrencies.append_val( stmt.column_text (i) );  
                }

            }
        }

        return selectedCurrencies;

    }


    public int addSelectedCurrency(string currency_id) {

        string errmsg;

        string query = "
            INSERT INTO selected_currencies (currency_id) 
            VALUES ('" + currency_id +"');
            ";

        int ec = db.exec (query, null, out errmsg);
        if (ec != Sqlite.OK) {
            stderr.printf ("Error: %s\n", errmsg);
            return -1;
        }

        return 1;

    }


    public int deleteSelectedCurrency(string currency_id) {

        string errmsg;

        string query = "
            DELETE FROM selected_currencies WHERE currency_id='" + currency_id +"'";

        int ec = db.exec (query, null, out errmsg);
        if (ec != Sqlite.OK) {
            stderr.printf ("Error: %s\n", errmsg);
            return -1;
        }

        return 1;

    }


}