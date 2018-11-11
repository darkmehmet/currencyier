public class HeaderBar : Gtk.Box { 

    public HeaderBar() {

        //  base(Gtk.Orientation.HORIZONTAL, 0);

        //  this = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);

        this.name = "headerbar";
        this.height_request = 70;
    
        var searchBox = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
        
        searchBox.height_request = 35;
        //  searchBox.width_request = 200;
    
        var search_entry = new Gtk.Entry ();
        search_entry.activates_default = false;
        search_entry.input_purpose = Gtk.InputPurpose.NUMBER ;
        search_entry.name = "search_entry";
        search_entry.placeholder_text = "Value";
        search_entry.text = "Value...";
        search_entry.width_request = 210;
    
        //search_entry.padding = 0;
        
    
        //  search_entry.get_frame_size(0,0,200,35);
    
        searchBox.pack_start(search_entry, false, false, 0);
    
    
        
        this.pack_start(searchBox, false, false, 0);
        
    
        this.pack_start(new Gtk.Box (Gtk.Orientation.VERTICAL, 0), false, false, 0);
    
    }
    
}
