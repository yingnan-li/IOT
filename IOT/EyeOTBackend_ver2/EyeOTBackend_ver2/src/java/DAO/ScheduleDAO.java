/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Entity.Officer;
import Entity.Schedule;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author user
 */
public class ScheduleDAO {
    public List<Schedule> getOffierSchedule(String dateString) throws ParseException{
        List<Schedule> schedules = new ArrayList<>();
        
        String sqlQuery="SELECT * FROM schedule s inner join officer o on s.empID=o.empID where date =?";
        
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(sqlQuery)) {
            
             DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        //get current date time with Date()
//        java.util.Date date = new java.util.Date();
       long timeInMillis = new SimpleDateFormat("yyyy-MM-dd").parse(dateString).getTime();
             java.sql.Date date1 = new java.sql.Date(timeInMillis);
            
            
            ps.setDate(1, date1);
            ResultSet results = ps.executeQuery();
            while(results.next()){
                String name = results.getString("name"); 
                String phone = results.getString("phone_num"); 
                int start = results.getInt("start_time"); 
                int end = results.getInt("end_time"); 
                String image=results.getString("image");
                Officer officer = new Officer(phone, name);
                officer.setImage(image);
                Schedule sch=new Schedule(start, end, new SimpleDateFormat("yyyy-MM-dd").parse(dateString), officer);
                schedules.add(sch);
                
            }
            
          
        } catch (SQLException ex) {
            Logger.getLogger(PiOnTrolleytoBeaconDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return schedules;
        
    }
}
