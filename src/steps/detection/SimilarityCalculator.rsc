module steps::detection::SimilarityCalculator

import steps::detection::RequirementsReader;
import steps::detection::Vectorizer;

import util::Math;
import IO;
import Set;
import List;
import Relation;

alias SimilarityMatrix = rel[str highlevel, str lowlevel, real score];

SimilarityMatrix calculateSimilarityMatrix(Requirement highlevel, Requirement lowlevel, Vector vec) {
	list[real] getVector(str name) {
		return getOneFrom(vec[name]);
	}
  
	return { <h.name, l.name, cos(getVector(h.name), getVector(l.name))> | h <- highlevel, l <- lowlevel };
}

@doc {
  Calculate the cosinus of two (real) vectors.
}
real cos(list[real] high, list[real] low) {
	real top = (0. | it + high[i] * low[i] | int i <- [0..size(high)]);
	
	real x = sqrt((0. | it + h * h | real h <- high));
	real y = sqrt((0. | it + l * l | real l <- low));
	
	return top / (x * y);
}