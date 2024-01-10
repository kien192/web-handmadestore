package model.bean;

public class Tips {
    private String title;
    private String description;
    private String img_path;
    private String video_link;

    public Tips() {

    }

    public Tips(String title, String description, String img_path, String video_link) {
        this.title = title;
        this.description = description;
        this.img_path = img_path;
        this.video_link = video_link;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImg_path() {
        return img_path;
    }

    public void setImg_path(String img_path) {
        this.img_path = img_path;
    }

    public String getVideo_link() {
        return video_link;
    }

    public void setVideo_link(String video_link) {
        this.video_link = video_link;
    }

    @Override
    public String toString() {
        return "Tips{" +
                "title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", img_path='" + img_path + '\'' +
                ", video_link='" + video_link + '\'' +
                '}';
    }
}
