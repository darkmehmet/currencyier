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
    
        //  // Insert test data:
        //  string query = """
        //      CREATE TABLE currencies (
        //          currency_id TEXT NOT NULL,
        //          currency_value TEXT NOT NULL,
        //          last_updated INT NOT NULL
        //      );
        //      """;
        //      //  INSERT INTO User (id, name) VALUES (1, 'Hesse');
        //      //  INSERT INTO User (id, name) VALUES (2, 'Frisch');
        //      //  """;
        //  ec = db.exec (query, null, out errmsg);
        //  if (ec != Sqlite.OK) {
        //      stderr.printf ("Error: %s\n", errmsg);
        //      return -1;
        //  }
    
        return 0;
    }


    public int getCurrency(string currency_id) {

        string errmsg;


        Sqlite.Statement stmt;

        const string prepared_query_str = "SELECT * FROM currencies WHERE currency_id = $CURRENCY_ID;";
        int ec = db.prepare_v2 (prepared_query_str, prepared_query_str.length, out stmt);
        if (ec != Sqlite.OK) {
            stderr.printf ("Error: %d: %s\n", db.errcode (), db.errmsg ());
            return -1;
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

                string col_name = stmt.column_name (i) ?? "<none>";
                string val = stmt.column_text (i) ?? "<none>";
                int type_id = stmt.column_type (i);

                print ("column: %s\n", col_name);
                print ("value: %s\n", val);
                print ("type: %d\n", type_id);
            }
        }

        return 1;

    }

    public int setCurrency(string currency_id, double value) {

        string errmsg;

        string query = "
            INSERT INTO currencies (currency_id, currency_value, last_updated) 
            VALUES ('" + currency_id +"', '" + value.to_string() + "', 546465);
            ";

        int ec = db.exec (query, null, out errmsg);
        if (ec != Sqlite.OK) {
            stderr.printf ("Error: %s\n", errmsg);
            return -1;
        }

        return 1;


    }
}