package dao;

import model.Bill;
import model.BillItem;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BillDAO {
    public boolean addBill(Bill bill) {
        String sql = "INSERT INTO bills (account_no, amount, bill_date) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, bill.getAccountNo());
            ps.setDouble(2, bill.getAmount());
            ps.setDate(3, new java.sql.Date(bill.getBillDate().getTime()));
            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int billId = rs.getInt(1);
                        BillItemDAO billItemDAO = new BillItemDAO();
                        if (bill.getBillItems() != null) {
                            for (BillItem item : bill.getBillItems()) {
                                item.setBillId(billId);
                                billItemDAO.addBillItem(item);
                            }
                        }
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Bill> getBillsByAccountNo(int accountNo) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills WHERE account_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountNo);
            try (ResultSet rs = ps.executeQuery()) {
                BillItemDAO billItemDAO = new BillItemDAO();
                while (rs.next()) {
                    int billId = rs.getInt("bill_id");
                    List<BillItem> billItems = billItemDAO.getBillItemsByBillId(billId);
                    Bill bill = new Bill(
                        billId,
                        rs.getInt("account_no"),
                        rs.getDouble("amount"),
                        rs.getDate("bill_date"),
                        billItems
                    );
                    bills.add(bill);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    public List<Bill> getAllBills() {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                BillItemDAO billItemDAO = new BillItemDAO();
                while (rs.next()) {
                    int billId = rs.getInt("bill_id");
                    List<BillItem> billItems = billItemDAO.getBillItemsByBillId(billId);
                    Bill bill = new Bill(
                        billId,
                        rs.getInt("account_no"),
                        rs.getDouble("amount"),
                        rs.getDate("bill_date"),
                        billItems
                    );
                    bills.add(bill);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }
}