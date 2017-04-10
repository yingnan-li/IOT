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
public class Trolleypi_beacon_event {
    private String PiID;
    private String TrolleyID;
    private String BeaconID;
    private String Timestamp;
    private String Time;

    public Trolleypi_beacon_event(String PiID, String TrolleyID, String BeaconID, String Timestamp) {
        this.PiID = PiID;
        this.TrolleyID = TrolleyID;
        this.BeaconID = BeaconID;
        this.Timestamp = Timestamp;
    }

    public Trolleypi_beacon_event(String PiID, String TrolleyID, String BeaconID, String Timestamp, String Time) {
        this.PiID = PiID;
        this.TrolleyID = TrolleyID;
        this.BeaconID = BeaconID;
        this.Timestamp = Timestamp;
        this.Time = Time;
    }

    public String getPiID() {
        return PiID;
    }

    public void setPiID(String PiID) {
        this.PiID = PiID;
    }

    public String getTrolleyID() {
        return TrolleyID;
    }

    public void setTrolleyID(String TrolleyID) {
        this.TrolleyID = TrolleyID;
    }

    public String getBeaconID() {
        return BeaconID;
    }

    public void setBeaconID(String BeaconID) {
        this.BeaconID = BeaconID;
    }

    public String getTimestamp() {
        return Timestamp;
    }

    public void setTimestamp(String Timestamp) {
        this.Timestamp = Timestamp;
    }

    public String getTime() {
        return Time;
    }

    public void setTime(String Time) {
        this.Time = Time;
    }
    
    
}
