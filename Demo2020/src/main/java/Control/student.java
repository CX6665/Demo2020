package Control;

public class student {
    private String name;
    private String sex;
    private String age;
    private String foulor;
    private String id;

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

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public String getFoulor() {
        return foulor;
    }

    public void setFoulor(String foulor) {
        this.foulor = foulor;
    }

    @Override
    public String toString() {
        return "student{" +
                "name='" + name + '\'' +
                ", sex='" + sex + '\'' +
                ", age='" + age + '\'' +
                ", foulor='" + foulor + '\'' +
                ", id=" + id +
                '}';
    }
}
