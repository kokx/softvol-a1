module steps::detection::Vectorizer

import steps::detection::RequirementsReader;

import List;
import util::Math;
import IO;

alias Vector = rel[str name, list[real] freq];

Vector calculateVector(Requirement reqs, list[str] vocabulary) {
	// REMOVE BELOW LINE, ONLY HERE TO MAKE THE TEMPLATES RUNNABLE
	words = [ w | r <- reqs, w <- r.words ];
	occurences = distribution(words);
	
	 //calculateInverseDocumentFrequency(occurences, vocabulary);
	
	
	return {};
}

@doc {
  Calculates the Inverse Document Frequency (IDF) of the different words in the vocabulary
  The 'occurences' map should map each word of the vocabulary to the number of times it occurs in the requirements.
  The 'occurences' map should have entries for all the words in the vocabulary, otherwise an exception will be thrown.
}
private map[str,real] calculateInverseDocumentFrequency(map[str,int] occurences, list[str] vocabulary, Requirement reqs) {
  	int nrOfReqs = size(reqs);
  	map[str,real] idfs = (w : log2(nrOfReqs / occurences[w]) | str w <- vocabulary); 

  	return idfs;
}

void main() {
	Requirement reqs2 = { <"f1", ["a", "funny", "business"]>, <"f2", ["another", "funny", "thing"]> };
	vocabulary = dup([ w | r <- reqs, w <- r.words ]);
	
	words = [ w | r <- reqs, w <- r.words ];
	occurences = distribution(words);

	println(size(reqs));
	//println(calculateInverseDocumentFrequency(occurences, vocabulary, reqs));
	//println(vocabulary);
}
