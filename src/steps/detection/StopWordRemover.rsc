module steps::detection::StopWordRemover

import IO;
import String;
import Set;
import List;

import steps::detection::RequirementsReader;


list[str] generateBigrams(list[str] words) {
	if (size(words) < 2) {
		return words;
	}
  		
	return words + [ words[i] + " " + words[i+1] | i <- [0..(size(words) - 1)] ];
}

  	
Requirement removeStopWords(Requirement reqs) {	  
	//reqs = { <r.name, generateBigrams(r.words - readStopwordsList)> | r <- reqs };
	reqs = { <r.name, r.words - readStopwordsList> | r <- reqs };
  
  	return reqs;
}

// TODO: Add extra functions if wanted / needed

private set[str] readStopwords() =
	{word | /<word:[a-zA-Z\"]+>/ := readFile(|project://assignment1/data/stop-word-list.txt|)};

private set[str] readExtraStopwords() =
	{word | /<word:[a-zA-Z\"]+>/ := readFile(|project://assignment1/data/extra-stop-word-list.txt|)};

list[str] readStopwordsList = toList(readStopwords()) + toList(readExtraStopwords());