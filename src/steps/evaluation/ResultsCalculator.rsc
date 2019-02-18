module steps::evaluation::ResultsCalculator

import steps::detection::RequirementsReader;
import steps::detection::TraceLinkConstructor;

import Set;
import util::Math;
import IO;

alias ConfusionMatrix = tuple[int truePositives, int falsePositives, int trueNegatives, int falseNegatives];
alias EvaluationResult = tuple[ConfusionMatrix cm, real precision, real recall, real fMeasure];

EvaluationResult evaluateMethod(TraceLink manual, TraceLink fromMethod, Requirement highlevel, Requirement lowlevel) {
	cm = calculateConfusionMatrix(manual, fromMethod, highlevel, lowlevel);
	precision = calculatePrecision(cm);
	recall = calculateRecall(cm);
	fMeasure = calculateFMeasure(precision, recall);
	
	return <cm, precision, recall, fMeasure>;
}

private real calculatePrecision(ConfusionMatrix cm) {
  	// Precision = TP / (TP + FP)
  
	return 1.0 * (cm.truePositives / (cm.truePositives + cm.falsePositives));
}

private real calculateRecall(ConfusionMatrix cm) { 
  	// Recall = TP / (TP + FN)
  
  	return 1.0 * (cm.truePositives / (cm.truePositives + cm.falseNegatives));
}

private real calculateFMeasure(real precision, real recall) {
  	// F1-score = 2 * (precision * recall) / (precision + recall)
  
  	return 1.0 * (2 * ((precision * recall) / (precision + recall)));
}

private ConfusionMatrix calculateConfusionMatrix(TraceLink manual, TraceLink automatic, Requirement highlevel, Requirement lowlevel) {
	// True positives: Nr of trace-link predicted by the tool AND identified manually  
  	// False positives: Nr of trace-link predicted by the tool BUT NOT identified manually
  	// True negatives: Nr of trace-link NOT predicted by the tool AND NOT identified manually
  	// False negatives: Nr of trace-link NOT predicted by the tool BUT identified manually
  
  	TP = size(manual & automatic);
  	FP = size(automatic - manual);
  	TN = size(highlevel join lowlevel) - size(manual) - size(automatic);
  	FN = size(manual - automatic);

	return <TP,FP,TN,FN>;
}