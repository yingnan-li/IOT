/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

/**
 *
 * @author user
 */
public class Pi {
    private String piID;
    private String placed_location;
    private String type;

    public Pi(String piID) {
        this.piID = piID;
    }

    public Pi(String piID, String placed_location, String type) {
        this.piID = piID;
        this.placed_location = placed_location;
        this.type = type;
    }

    public String getPiID() {
        return piID;
    }

    public void setPiID(String piID) {
        this.piID = piID;
    }

    public String getPlaced_location() {
        return placed_location;
    }

    public void setPlaced_location(String placed_location) {
        this.placed_location = placed_location;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
    
}
