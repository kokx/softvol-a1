module steps::detection::VocabularyBuilder

import steps::detection::RequirementsReader;

import List;


list[str] extractVocabulary(Requirement reqs) {
  words = [ w | r <- reqs, w <- r.words ];
  
  return dup(words); 
}