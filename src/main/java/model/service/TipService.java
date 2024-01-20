package model.service;

import model.bean.BannerItem;
import model.bean.Tip;
import model.dao.BannerItemDAO;
import model.dao.TipDAO;
import model.db.JDBIConnector;

import java.util.List;

public class TipService {
    private static TipService instance;

    public static TipService getInstance() {
        if (instance == null) instance = new TipService();
        return instance;
    }

    public List<Tip> getAll() {
        return TipDAO.getAllTips();
    }

    public Tip getTipByTitle(String title) {
        return TipDAO.getTipByTitle(title);
    }

    public void deleteTipByTitle(String title) {
        TipDAO.deleteTipByTitle(title);
    }

    public static void updateByTitle(String oldTitle, String newTitle, String description, String videoLink) {
        TipDAO.updateByTitle(oldTitle, newTitle, description, videoLink);
    }

    public static void main(String[] args) {
        List<Tip> categories = TipService.getInstance().getAll();
        for (Tip c : categories) {
            System.out.println(c.toString());
        }
    }
}
