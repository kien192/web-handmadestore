package model.service;

import model.bean.Tip;
import model.dao.TipDAO;

import java.util.List;

public class TipService {
    private static TipService instance;

    public static TipService getInstance() {
        if(instance == null) new TipService();
        return instance;
    }

    public List<Tip> getAll() {
        return TipDAO.getAllTips();
    }

    public static void main(String[] args) {
        List<Tip> categories = TipService.getInstance().getAll();
        for(Tip c : categories) {
            System.out.println(c.toString());
        }
    }
}
