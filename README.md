DNSLookup
===========

A CFC for retrieving DNS record type values from a supplied domain.

This is ultimately a work in progress and there is a fair share of bits to add/edit depending on what results could be from a given record type.

The "lookup" functions cover DNS types listed at http://en.wikipedia.org/wiki/List_of_DNS_record_types.

Some notes. . .

* Formatting of data has been applied to known outputs that could be tested, so some arrays may contain a string of multiple values that would still need to be parsed.
* If the domain does not exist, a NamingException is thrown. I plan to handle this in a less error-in-your-face way.
* If a given DNS type is not found or no records are available, the lookup*() function will return a array containing the domain name supplied. This is a temporary method of handling every type of DNS lookup for now.
