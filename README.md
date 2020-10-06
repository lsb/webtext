# webtext

Recreating the Reddit-based WebText dataset from publicly available sources.

Notably, nowhere in the GPT-2 or GPT-3 papers is there discussion of filtering the URLs by community history of abuse. This compendium follows that lead, with over 5.7M links (and counting) from communities that have been quarantined and/or banned from Reddit. Collectively, those submissions have over 1.3 billion karma points, out of 53 billion karma points in all.

The links are available, in one-to-one mappings to the pushshift dataset, with *u*rl/sub*r*eddit/*k*arma extracted, in gzipped newline-separated json object format.
