/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Entity.Beacon;
import Entity.Trolleypi_beacon_event;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Jason
 */
public class Trolleypi_beacon_eventDAO {
    
    private final String PIID = "PiID";
    private final String TROLLEY_ID = "TrolleyID";
    private final String BEACON_ID = "BeaconID";
    private final String HOUR = "hour";
    private final String TIME = "timestamp";
    
    public List<Trolleypi_beacon_event> getAllBeaconEvent(){
        
        List<Trolleypi_beacon_event> beaconEventList = new ArrayList<>();
        String sqlQuery = "SELECT PiID, TrolleyID, BeaconID, HOUR(Timestamp) as hour, Time(Timestamp) as timestamp FROM `trolleypi_beacon_event` group by HOUR(Timestamp)";
        
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sqlQuery)) {
            
            ResultSet results = ps.executeQuery();
            while(results.next()){
                String PiID = results.getString(PIID);
                String TrolleyID = results.getString(TROLLEY_ID);                  
                String BeaconID = results.getString(BEACON_ID);                  
                String Hour = results.getString(HOUR);                  
                String Time = results.getString(TIME);                  
                Trolleypi_beacon_event beaconEvent = new Trolleypi_beacon_event(PiID, TrolleyID, BeaconID, Hour, Time);
                beaconEventList.add(beaconEvent);
            }
            
          
        } catch (SQLException ex) {
            Logger.getLogger(PiOnTrolleytoBeaconDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return beaconEventList;
        
    }
    public int getAllMissingBeaconCount(){
        
        int num_of_missing_trolley = 0;
        String sqlQuery = "select * from trolleypi_beacon_event a inner join ( SELECT TrolleyID, max(Timestamp) as test "
                + "FROM `trolleypi_beacon_event` group by TrolleyID ) as temp on a.TrolleyID = temp.TrolleyID "
                + "and a.Timestamp = temp.test where isBack = 'false'";
        
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sqlQuery)) {
            
            ResultSet results = ps.executeQuery();
            while(results.next()){
                num_of_missing_trolley++;
            }
            
          
        } catch (SQLException ex) {
            Logger.getLogger(PiOnTrolleytoBeaconDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return num_of_missing_trolley;
        
    }
    public List<Trolleypi_beacon_event> getAllMissingBeaconEvent(){
        
        List<Trolleypi_beacon_event> beaconEventList = new ArrayList<>();
        String sqlQuery = "SELECT PiID, TrolleyID, BeaconID, HOUR(Timestamp) as hour, Time(Timestamp) as timestamp FROM `trolleypi_beacon_event` where isBack = 'false'";
        
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sqlQuery)) {
            
            ResultSet results = ps.executeQuery();
            while(results.next()){
                String PiID = results.getString(PIID);
                String TrolleyID = results.getString(TROLLEY_ID);                  
                String BeaconID = results.getString(BEACON_ID);                  
                String Hour = results.getString(HOUR);                  
                String Time = results.getString(TIME);                  
                Trolleypi_beacon_event beaconEvent = new Trolleypi_beacon_event(PiID, TrolleyID, BeaconID, Hour, Time);
                beaconEventList.add(beaconEvent);
            }
            
          
        } catch (SQLException ex) {
            Logger.getLogger(PiOnTrolleytoBeaconDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return beaconEventList;
        
    }
}
