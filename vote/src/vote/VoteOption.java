package vote;

import java.util.*;

public class VoteOption {
    int idQuestion;
    int option_id;
    String option_text;
    int counter;    

    //Default constructor
    public VoteOption() {
	setDefaults();
    }
    

    public VoteOption(int p) {
	setDefaults();
	idQuestion = p;
    }

    public VoteOption(int p, int i) {
	setDefaults();
	idQuestion = p;
	option_id = i;
    }

    public VoteOption(int p, int i, String t) {
    	idQuestion = p;
	option_id = i;
	option_text = t;
	counter = 0;
    }

    public VoteOption(int p, int i, String t, int c) {
    	idQuestion = p;
	option_id = i;
	option_text = t;
	counter = c;
    }

    public VoteOption(int p, String i, String t, String c) {
    	idQuestion = p;
	option_id = Integer.parseInt(i);
	option_text = t;
	counter = Integer.parseInt(c);
    }

    public int getPollid() { return idQuestion; }
    public int getOptionid() { return option_id; }
    public String getOptiontext() { return option_text; }
    public int getCounter() { return counter; }

    public void setPollid(int value) { value = idQuestion;  }
    public void setOptionid(int value) { value = option_id;  }
    public void setOptiontext(String value) { value = option_text;  }
    public void setCounter(int value) { value = counter;  }

    private void setDefaults() {
    	idQuestion = 0;
	option_id = 0;
	option_text = "";
	counter = 0;
    }
}