module steps::detection::RequirementsReader

import IO;
import String;
import List;

import DataSet;

alias Requirement = rel[str name, list[str] words]; 

// You can use this file 'as-is'. You do not have to read and parse the requirement files yourself.
// If you want more sofisticated methods of parsing the words and lines of the requirement files 
// you could implement the functions: 'applyHighlevelFiltering', 'applyLowlevelLineFiltering' and 'applyLowlevelWordFiltering'

Requirement readHighlevelRequirements(DataSet grp) {
	list[str] requirements = readRequirements(grp.dir, "high_level.txt");

	Requirement result = {};

	for (str req <- requirements, /^<id:F[0-9]+>\s<text:.*>$/ := trim(req)) { // Only consider Functional req not NonFunctionals
		list[str] reqWords = [applyHighlevelFiltering(toLowerCase(word)) | /<word:\S+>/ := text];
		result += {<id, reqWords>}; 
	}
	
	return result;
}

Requirement readLowlevelRequirements(DataSet grp) {
	list[str] requirements = readRequirements(grp.dir, "low_level.txt");
	
	Requirement result = {};
	
	for (str req <- requirements, /^<id:UC[0-9]+>/ := trim(req)) {
		list[str] reqWords = [];
		
		for (str line <- split("\n", trim(req))) {
			reqWords += [applyLowlevelWordFiltering(toLowerCase(word)) | str fLine := applyLowlevelLineFiltering(line), /<word:\S+>/ := fLine];
		}
		
		result += {<id, reqWords>}; 
	}
	
	return result;
}

private str removePunctuation(str input) {
    input = replaceAll(input, ".", "");
    input = replaceAll(input, ",", "");
    input = replaceAll(input, "\'", "");
    input = replaceAll(input, "\"", "");
    input = replaceAll(input, "-", "");
    input = replaceAll(input, "_", "");
    input = replaceAll(input, ":", "");

    return input;
}

private str applyHighlevelFiltering(str orig) {
    // This is the spot to implement some extra filtering if wanted while reading in the highlevel requirements
    // This function gets called for EVERY word in the highlevel requirements text
    
    return removePunctuation(orig);
}

private str applyLowlevelLineFiltering(str origLine) {
    // This is the spot to implement some extra filtering if wanted while reading in the lowlevel requirements
    // This function gets called for EVERY word in the lowlevel requirements text
    
    // we remove M[0-9] (authors), UC[0-9]+ (reqs)
    
    origLine = visit(origLine) {
        // removes all authors
        case /Authors:\s+(M[0-9]+|[A-Z]\.[A-Z]\.(, )?)+/ => ""
        // removes all UC's
        case /UC[0-9]+/ => ""
    };
        
    return origLine;
}
private str applyLowlevelWordFiltering(str origWord) {
	// TODO: This is the spot to implement some extra filtering if wanted while reading in the lowlevel requirements
	// This function gets called for EVERY word in the lowlevel requirements text
	
	return removePunctuation(origWord);
}

private list[str] readRequirements(loc dir, str fileName) =
	split("~", readFile(dir + "/<fileName>"));
