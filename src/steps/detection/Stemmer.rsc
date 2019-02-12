module steps::detection::Stemmer

import analysis::stemming::Snowball;

import steps::detection::RequirementsReader;

import IO;

Requirement stemWords(Requirement reqs) {
  reqs = { <r.name, stemAll(r.words)> | r <- reqs }; 
  
  return reqs;
}

@doc {
  Returns the passed in list of words in a stemmed form
}
private list[str] stemAll(list[str] orig) = [porterStemmer(w) | w <- orig];