package model.dao;

import model.bean.Tips;
import model.db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;

public class TipsDAO {
    public static List<Tips> tipsList(){
        List<Tips> result = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM tips")
                        .mapToBean(Tips.class)
                        .stream().collect(Collectors.toList()));
        return result;
    }

    public static void main(String[] args) {
        List<Tips> result = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM tips")
                        .mapToBean(Tips.class)
                        .stream().collect(Collectors.toList()));
        System.out.println(result.toString());
    }

}
