package model.bean;

public class Image {
    private String id;
    private String name;
    private String path;
    private String productId;

    public Image() {
    }

    public Image( String name, String path, String productId) {
        this.name = name;
        this.path = path;
        this.productId = productId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    @Override
    public String toString() {
        return "Image{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", path='" + path + '\'' +
                ", productId='" + productId + '\'' +
                '}';
    }
}
