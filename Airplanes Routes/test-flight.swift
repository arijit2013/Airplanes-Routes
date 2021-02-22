/* 
This is about finding the right route of airplanes routes. Considering doing this in a dynamic fashion. Forget that google exists and do it like you imagine best in your opinion .
We do know when you google or use an answer from online. So do it all from your own imagination even if you submit it wrong that is not 100% the way we value your code. 
We check for process of thinking rather than the solution.

The start airport is the one that’s on the first position of any segment, but isn’t in the second position of any other segment, it only appears in the first position. And the end is the only one that only appears in the second position given any segment. It never appears in the first position.

Imagine you have a travel agency and you receive a list of 
Origin->Destination airports, in random order. 

Now you need to reorder the list, to be in the correct sequence.

Example input:
input = [
   ["JFK", "SFO"],
   ["BOS", "MIA"],
   ["SFO", "PEK"],
   ["MIA", "JFK"],
]

Correct output for the above example:
output = [
   ("BOS", "MIA"),
   ("MIA", "JFK"),
   ("JFK", "SFO"),
   ("SFO", "PEK"),
]
 */