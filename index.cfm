<cfscript>
	
	lookup = createObject("component", "DNSLookup").init("google.com");

	writeOutput("<h3>Examples for google.com</h3>");

	writeOutput("<h5>SOA</h5>");
	writeDump(lookup.lookupSOA());
	writeOutput("<h5>MX</h5>");
	writeDump(lookup.lookupMX());
	writeOutput("<h5>NS</h5>");
	writeDump(lookup.lookupNS());
	writeOutput("<h5>A</h5>");
	writeDump(lookup.lookupA());

</cfscript>