package buildbot;

import javax.persistence.*;

@Entity
@Table(name = "user_build_steps")
public class UserBuildStep {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "build_id")
    private UserBuild build;

    private int stepNumber;
    private String instruction;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public UserBuild getBuild() {
        return build;
    }

    public void setBuild(UserBuild build) {
        this.build = build;
    }

    public int getStepNumber() {
        return stepNumber;
    }

    public void setStepNumber(int stepNumber) {
        this.stepNumber = stepNumber;
    }

    public String getInstruction() {
        return instruction;
    }

    public void setInstruction(String instruction) {
        this.instruction = instruction;
    }

    
}
