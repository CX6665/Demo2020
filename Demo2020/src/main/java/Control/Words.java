package Control;

public class Words {
    private String Szm;
    private String Word;
    private String Meaning;
    private String Example;

    public String getSzm() {
        return Szm;
    }
    public void setSzm(String szm) {
        Szm = szm;
    }
    public String getWord() {
        return Word;
    }
    public void setWord(String word) {
        Word = word;
    }
    public String getMeaning() {
        return Meaning;
    }
    public void setMeaning(String meaning) {
        Meaning = meaning;
    }
    public String getExample() {
        return Example;
    }
    public void setExample(String example) {
        Example = example;
    }
    @Override
    public String toString() {
        return "Words{" +
                "Szm='" + Szm + '\'' +
                ", Word='" + Word + '\'' +
                ", Meaning='" + Meaning + '\'' +
                ", Example='" + Example + '\'' +
                '}';
    }
}
