module steps::detection::StopWordRemover

import IO;
import String;
import Set;

import steps::detection::RequirementsReader;

Requirement removeStopWords(Requirement reqs) {  
  reqs = { <r.name, r.words - readStopwordsList> | r <- reqs }; 
  
  return reqs;
}

// TODO: Add extra functions if wanted / needed

private set[str] readStopwords() =
	{word | /<word:[a-zA-Z\"]+>/ := readFile(|project://assignment1/data/stop-word-list.txt|)};

list[str] readStopwordsList = toList(readStopwords());