/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

/**
 *
 * @author Jason
 */
public class Beacon {
    private String id;
    private String location;
    private String type;

    public Beacon(String id, String location) {
        this.id = id;
        this.location = location;
    }

    public Beacon(String id, String location, String type) {
        this.id = id;
        this.location = location;
        this.type = type;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
    
}
