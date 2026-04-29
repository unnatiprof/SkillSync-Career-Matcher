package skillsync;

public class Instructor {

    private int id;
    private String name;
    private String skills;
    private String language;
    private int experience;
    private int hourlyRate;
    private double rating;
    private String profileImage;

    // Getters and Setters

    public int getId() 
    { 
    	    return id; 
    }
    public void setId(int id) 
    { 
    	    this.id = id; 
    	}

    public String getName() 
    { 
    	    return name; 
    	}
    public void setName(String name) 
    { 
    	    this.name = name; 
    	}

    public String getSkills() 
    { 
    	    return skills; 
    	}
    public void setSkills(String skills) 
    { 
    	   this.skills = skills; 
    	}

    public String getLanguage() 
    { 
    	   return language; 
    	}
    public void setLanguage(String language) 
    { 
    	   this.language = language; 
    	}

    public int getExperience() 
    { 
    	   return experience; 
    	}
    public void setExperience(int experience) 
    { 
    	   this.experience = experience; 
    	}

    public int getHourlyRate() 
    { 
    	   return hourlyRate; 
    	}
    
    public void setHourlyRate(int hourlyRate) 
    { 
    	   this.hourlyRate = hourlyRate; 
    	}

    public double getRating() 
    { 
    	   return rating; 
    	}
    public void setRating(double rating) 
    { 
    	   this.rating = rating; 
    	}

    public String getProfileImage() 
    { 
    	   return profileImage; 
    	}
    public void setProfileImage(String profileImage) 
    { 
    	   this.profileImage = profileImage; 
    	}
}