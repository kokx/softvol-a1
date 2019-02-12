module steps::detection::StopWordRemover

import IO;
import String;
import Set;

import steps::detection::RequirementsReader;

Requirement removeStopWords(Requirement reqs) {
  // TODO: Remove the stop words from the words lists of all the requirements.
  
  // REMOVE BELOW LINE, ONLY HERE TO MAKE THE TEMPLATES RUNNABLE
  return reqs;
}

// TODO: Add extra functions if wanted / needed

private set[str] readStopwords() =
	{word | /<word:[a-zA-Z\"]+>/ := readFile(|project://assignment1/data/stop-word-list.txt|)};
