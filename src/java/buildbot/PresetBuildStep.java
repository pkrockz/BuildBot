package buildbot;

import javax.persistence.*;

@Entity
@Table(name = "preset_build_steps")
public class PresetBuildStep {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "build_id")
    private PresetBuild build;

    private int stepNumber;
    private String instruction;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public PresetBuild getBuild() {
        return build;
    }

    public void setBuild(PresetBuild build) {
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
