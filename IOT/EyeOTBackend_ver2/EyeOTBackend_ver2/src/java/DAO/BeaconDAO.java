/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Entity.Beacon;
import Entity.Pi;
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
public class BeaconDAO {
    
    private final String BEACON_ID = "BeaconID";
    private final String LOCATION_COL = "Location";
    
    public Beacon getBeaconDetails(String beaconID){
        
        Beacon beacon = null;
        String sqlQuery = "SELECT * FROM beacon where BeaconID = ?";
        
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sqlQuery)) {
            
            ps.setString(1, beaconID);
            
            ResultSet results = ps.executeQuery();
            while(results.next()){
                String id = results.getString(BEACON_ID);
                String location = results.getString(LOCATION_COL);                  
                beacon = new Beacon(id, location); //  Beacon(String id, String location)
            }
            
          
        } catch (SQLException ex) {
            Logger.getLogger(PiOnTrolleytoBeaconDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return beacon;
        
    }
    
    public List<Beacon> getAllBeaconDetails(){
        
        List<Beacon> beaconList = new ArrayList<>();
        String sqlQuery = "SELECT * FROM beacon";
        
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sqlQuery)) {
            
            ResultSet results = ps.executeQuery();
            while(results.next()){
                String id = results.getString(BEACON_ID);
                String location = results.getString(LOCATION_COL);                  
                Beacon beacon = new Beacon(id, location); //  Beacon(String id, String location)
            }
            
          
        } catch (SQLException ex) {
            Logger.getLogger(PiOnTrolleytoBeaconDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return beacon;
        
    }
}
