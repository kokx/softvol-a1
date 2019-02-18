module steps::detection::Vectorizer

import steps::detection::RequirementsReader;

import List;
import util::Math;
import IO;
import Set;

alias Vector = rel[str name, list[real] freq];


Vector calculateVector(Requirement reqs, list[str] vocabulary) {
	occurences = distribution([ w | r <- reqs, w <- r.words ]);
	
	idf = calculateInverseDocumentFrequency(occurences, vocabulary, reqs);

	list[real] vectorize(list[str] words) {
		occurences = distribution(words);
	
		return [ w in occurences ? occurences[w] * idf[w] : 0.0 | w <- vocabulary ];					
	}
 
 	return { <r.name, vectorize(r.words)> | r <- reqs };
}

@doc {
  Calculates the Inverse Document Frequency (IDF) of the different words in the vocabulary
  The 'occurences' map should map each word of the vocabulary to the number of times it occurs in the requirements.
  The 'occurences' map should have entries for all the words in the vocabulary, otherwise an exception will be thrown.
}
private map[str,real] calculateInverseDocumentFrequency(map[str,int] occurences, list[str] vocabulary, Requirement reqs) {
  	num nrOfReqs = size(reqs);
  	map[str,real] idfs = (w : log2(nrOfReqs / occurences[w]) | str w <- vocabulary); 

  	return idfs;
}