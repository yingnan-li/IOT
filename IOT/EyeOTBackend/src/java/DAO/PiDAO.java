/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Entity.Officer;
import Entity.Pi;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author user
 */
public class PiDAO {
    private final String LOCATION_COL = "placed_location";
    private final String TYPE_COL = "type";
    
    
    public Pi getPiDetails(String piID){
        
        Pi pi = null;
        String sqlQuery="SELECT * FROM pi where PiID = ?";
        
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sqlQuery)) {
            
            ps.setString(1,piID);
            
            ResultSet results = ps.executeQuery();
            while(results.next()){
                String location = results.getString(LOCATION_COL); 
                String type = results.getString(TYPE_COL); 
                
                pi = new Pi(piID, location, type);
            }
            
          
        } catch (SQLException ex) {
            Logger.getLogger(BeaconPiDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pi;
        
    }
}
