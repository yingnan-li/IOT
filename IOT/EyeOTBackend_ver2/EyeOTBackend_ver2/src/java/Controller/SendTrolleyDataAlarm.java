/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.BeaconDAO;
import DAO.OfficerDAO;
import DAO.PiOnTrolleytoBeaconDAO;
import Entity.Officer;
import Utility.General;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author kunsheng
 */
@WebServlet(name = "SendTrolleyDataAlarm", urlPatterns = {"/SendTrolleyDataAlarm"})
public class SendTrolleyDataAlarm extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String beaconID = request.getParameter("BeaconID");
        String PiID = request.getParameter("PiID");
        String timestamp = request.getParameter("BeaconTimestamp");
        PiOnTrolleytoBeaconDAO piOnTrolleyToBeaconDAO = new PiOnTrolleytoBeaconDAO();
        piOnTrolleyToBeaconDAO.insertTrolleyAlarmEvent(beaconID, PiID, Long.parseLong(timestamp));
        
        BeaconDAO beaconDAO = new BeaconDAO();
        String location = beaconDAO.getBeaconDetails(beaconID).getLocation();
        OfficerDAO officerDao = new OfficerDAO();
        General general = new General();
        List<Officer> officerList = officerDao.getAvailableOfficerList();
        
        // sms is sent whenever alarm is triggered
        for (Officer officer : officerList) {
            String phoneNum = officer.getPhoneNum();
            String name = officer.getName();
            String msg = "Hello " + name + ",\n Please proceed to " + location + " to retrieve the trolley!";
            String url = general.sendSMS(phoneNum, msg);
            response.sendRedirect(url);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
