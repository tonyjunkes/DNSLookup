<cfscript>
	
	lookup = createObject("component", "DNSLookup").init("google.com");
	results = lookup.getDNSRecord("SOA,MX,NS,A");
	
	writeOutput("<h3>Examples for google.com</h3>");

	writeOutput("<h5>Dump of supplied list of DNS types (SOA,MX,NS,A)</h5>");
	writeDump(results);

	writeOutput("<h5>Example parsing output (in order - SOA,MX,NS)</h5>");
	writeDump(lookup.parseSOA(results.SOA));
	writeOutput("<br>");
	writeDump(lookup.parseMX(results.MX));
	writeOutput("<br>");
	writeDump(lookup.parseNS(results.NS));
</cfscript>