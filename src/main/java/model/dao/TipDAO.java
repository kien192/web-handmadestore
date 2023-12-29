package model.dao;

import model.bean.Tip;
import model.bean.User;
import model.db.JDBIConnector;
import model.service.TipService;

import java.util.List;
import java.util.stream.Collectors;

public class TipDAO {
    public static List<Tip> getAllTips() {
        List<Tip> tips = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from tips").mapToBean(Tip.class).stream().collect(Collectors.toList()));
        return tips;
    }

    public static void main(String[] args) {
        System.out.println("Noooo");
        List<Tip> tips = getAllTips();
        if(tips == null) System.out.println("no data");
        for(Tip c : tips) {
            System.out.println(c.toString());
        }
    }



}
