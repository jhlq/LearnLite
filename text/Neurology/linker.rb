links="1_1_Introduction.pdf
1_2_Cell_Membrane.pdf
1_3_Ion_Channels.pdf
1_4_MembranePotential.pdf
1_5_CableProperties.pdf
2_1_VoltageGatedChannels.pdf
2_2_VoltageGatingKinetics.pdf
2_3_TheActionPotential.pdf
2_4_ActionPotentialPropagation.pdf
2_5_WholeCellRecording.pdf
3_1_SynapticTransmission.pdf
3_2_NeurotransmitterRelease.pdf
3_3_PresynapticDynamics.pdf
3_4_PresynapticModulation.pdf
3_5_EM.pdf
4_1_GlutamateReceptors.pdf
4_2_PostsynapticPotentials.pdf
4_3_GlutamatergicCircuits.pdf
4_4_SynapticPlasticity.pdf
4_5_DendriticSpines.pdf
5_1_GABAergic_inhibition.pdf
5_2_Inhibitory_synaptic_conductances.pdf
5_3_Benzodiazepines.pdf
5_4_GABAergic_Projections.pdf
5_5_Neocortical_Inhibition.pdf
6_1_BrainFunctionAndBehavior.pdf
6_2_ManAndMouse.pdf
6_3_ImagingTheBrainInAction.pdf
6_4_InVivoElectrophysiology.pdf
6_5_ControllingBrainFunction.pdf
7_1_SensorimotorInteractions.pdf
7_2_SensoryPerception.pdf
7_3_Learning.pdf
7_4_BrainDysfunction.pdf
7_5_ConcludingRemarks.pdf"
la=links.split

wo=""
i=0
for wi in 1..7
	File.open("week#{wi}.txt", "r") do |f|
		f.each_line do |line|
			if line[0]=='!'
				wo+=line[0..5]+la[i]+line[13..line.length-2]+' '+la[i]+"\n"
				i+=1
			else
				wo+=line
			end
		end
	end
	File.write("week#{wi}.txt", wo)
	wo=""
end
File.write('test.txt', wo)
