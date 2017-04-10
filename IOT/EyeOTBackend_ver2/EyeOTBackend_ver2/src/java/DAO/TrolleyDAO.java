/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author user
 */
public class TrolleyDAO {

    private final String TROLLEY_ID = "TrolleyID";
    private final String LAST_BATTCHANGE = "lastBattChange";

    public HashMap<String, String> getBatteryMap() {
        HashMap<String, String> TrolleyList = new HashMap<String, String>();

        String sqlQuery = "SELECT * FROM trolley";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sqlQuery)) {

            ResultSet results = ps.executeQuery();
            while (results.next()) {
                String tID = results.getString(TROLLEY_ID);
                String lastBattChange = results.getString(LAST_BATTCHANGE);
                TrolleyList.put(tID, lastBattChange);
            }

        } catch (SQLException ex) {
            Logger.getLogger(PiOnTrolleytoBeaconDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return TrolleyList;
    }

    public static void resetBattery(String trolleyID) {
        String sqlQuery = "UPDATE trolley SET lastBattChange=NOW() WHERE `TrolleyID`=?;";
        //String sqlQuery = "insert into trolleypi_beacon_event values (?,(select TrolleyID from pi_on_trolley where PiID=?),?,?,?)";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sqlQuery)) {
            ps.setString(1, trolleyID);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TrolleyDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
