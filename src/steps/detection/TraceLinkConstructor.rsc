module steps::detection::TraceLinkConstructor

import steps::detection::SimilarityCalculator;
import List;
import Set;
import IO;

alias TraceLink = rel[str,str];
alias AllTraceLinks = list[TraceLink];

AllTraceLinks constructLinks(SimilarityMatrix sm) =
	[constructMethod1(sm), constructMethod2(sm), constructMethod3(sm)]; // You can add more constructed trace-links to the list if wanted

TraceLink constructMethod1(SimilarityMatrix sm) {
	//For every $h$, report all $l$ with the similarity score of at least 0.
	return { <s.highlevel, s.lowlevel> | s <- sm, s.score >= 0 };
}

TraceLink constructMethod2(SimilarityMatrix sm) {
	//For every $h$, report all $l$ with the similarity score of at least 0.25.
	return { <s.highlevel, s.lowlevel> | s <- sm, s.score > 0.25 };
} 

TraceLink constructMethod3(SimilarityMatrix sm) {
	// For every `h`, find `l` with the highest similarity score and report all `l'`,
	// such that `sim(h,l') ≥ 0.67 sim(h,l)`.
	rel[str highlevel, real score] highScore = { <h, max(sm[h]<1>)> | h <- sm.highlevel };
	
	matches = { r | r <- sm, r.score >= 0.67 * max(highScore[r.highlevel]) };
	
	return matches<highlevel, lowlevel>;
}