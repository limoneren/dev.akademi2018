import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.util.prefs.Preferences;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingConstants;

public class Main {


	public static void main(String args[]) {


		JFrame expFrame = new JFrame("Price Prediction Demo");
		expFrame.setVisible(true);
		expFrame.setSize(800, 600);
		expFrame.getContentPane().setBackground(Color.decode("#3F475F"));
		expFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		expFrame.setLayout(null);

		JPanel infoScreen = new JPanel();
		infoScreen.setBounds(150, 50, 500, 500);
		infoScreen.setBackground(Color.decode("#FFE801"));
		infoScreen.setLayout(null);
		expFrame.getContentPane().add(infoScreen);
	

		JTextField budgetInput = new JTextField();
		budgetInput.setBounds(150, 200, 100, 30);
		infoScreen.add(budgetInput);


		JTextField typeInput = new JTextField();
		typeInput.setBounds(250, 200, 100, 30);
		infoScreen.add(typeInput);

		JButton btn = new JButton();
		btn.setText("Get Price");
		btn.setVisible(true);
		btn.setBounds(200, 250, 100, 30);
		infoScreen.add(btn);

		JLabel lbl = new JLabel("Result");
		lbl.setForeground(Color.BLACK);
		lbl.setHorizontalAlignment(SwingConstants.CENTER);
		lbl.setBounds(170, 350, 150, 30);
		infoScreen.add(lbl);


		btn.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				lbl.setText(budgetInput.getText());
			}
		});

//		ProcessBuilder rScriptProcess = new ProcessBuilder();
//		
//		
//		
//		String rPath = "/Library/Frameworks/R.framework";
//		
//		ProcessBuilder pb = new ProcessBuilder(rPath, "rscript --vanilla ml_experiment.R 121212 bef");
//        try {
//			pb.start();
//		} catch (IOException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
        
//        try {
//			Runtime.getRuntime().exec("rscript mlExperiment.R");
//		} catch (IOException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		} 
		
		
		

	}


}
