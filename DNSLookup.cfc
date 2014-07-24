/**
* @hint A CFC for retrieving DNS records from a supplied domain.
* A list of DNS record types can be found at -
* http://en.wikipedia.org/wiki/List_of_DNS_record_types.
* @author Tony Junkes - @cfchef
* @version 1.2
*/
component name="DNSLookup"
    output="false"
{
    /**
    * @hint Initialize the DNSLookup object.
    * @param domainName The domain to lookup records from. (required)
    * @return Returns a DNSLookup object for further processing.
    */
    public DNSLookup function init(required string domainName = "")
        output="false"
    {
        VARIABLES.domain = ARGUMENTS.domainName;

        return THIS;
    }
    /**
    * @hint Returns a struct of key/values from a given DNS type.
    * @param dnsType (required)
    */
    public struct function getDNSRecord(required string dnsTypes = "")
        output="false"
    {
        var attributes = createObject(
            "java", "javax.naming.directory.InitialDirContext"
        ).getAttributes("dns:/" & VARIABLES.domain, javaCast("null", ""));
        var type = "";
        var records = attribute = [];
        var i = 0;
        var results = {};

        for (type in listToArray(ARGUMENTS.dnsTypes, ",")) {
            arrayClear(records);
            attribute = attributes.get(type);
            if (isDefined("attribute")) {
                for (i = 0; i < attribute.size(); i++) {
                    arrayAppend(records, attribute.get(i));
                }
                arraySort(records, "textnocase", "asc");
                structAppend(results, {"#type#" = records});
            } else {
                //If there are no records then default to domain name.
                arrayAppend(records, VARIABLES.domain);
                results[type] = records;
            }
        }

        return results;
    }

    /**********************************************************/
    /***** Helper functions for parsing select DNS types. *****/
    /**********************************************************/

    /**
    * @hint Returns a array of structs containing MX record values
    * sorted from most preferred to least preferred.
    * @param records (required)
    */
    public array function parseMX(required array records)
        output="false"
    {
        //see: RFC 974 - Mail routing and the domain system.
        //see: RFC 1034 - Domain names - concepts and facilities.
        //see: http://java.sun.com/j2se/1.5.0/docs/guide/jndi/jndi-dns.html -
        //DNS Service Provider for the Java Naming Directory Interface (JNDI).
        var pvhnSplit = results = [];
        var hostName = record = "";
        var preferenceValue = 0;

        //Split MX RRs into Preference Values(pvhnSplit[1]) and Host Names(pvhnSplit[2]),
        //remove any trailing periods from Host Names and assign to a array of
        //structs containing the split values.
        for (record in ARGUMENTS.records) {
            pvhnSplit = listToArray(record, " ");
            arrayAppend(results, {
                "preferenceValue" = pvhnSplit[1],
                "hostName" = reReplace(pvhnSplit[2], "\.$", "", "ALL")
            });
        }

        return results;
    }
    /**
    * @hint Returns a array of NS record values.
    * @param records (required)
    */
    public array function parseNS(required array records)
        output="false"
    {
        var results = [];
        var record = "";

        //remove any trailing periods from NS records.
        for (record in ARGUMENTS.records) {
            arrayAppend(results, reReplace(record, "\.$", "", "ALL"));
        }

        return results;
    }
    /**
    * @hint Returns a struct containing SOA record values.
    * As per RFC 1035 there should only be one record, though
    * some googling suggests multiple are possible.
    * Results will be assumed as a struct but return a array of
    * structs should there be multiple records.
    * @param records (required)
    */
    public any function parseSOA(required array records)
        output="false"
    {
        var zoneSplit = timers = [];
        var results = primaryNS = email = record = "";
        var domainSerial = 0;

        //Split SOA record into specified keys and values,
        //remove any trailing periods from Host/Domain Names and assign to a struct.
        for (record in ARGUMENTS.records) {
            zoneSplit = listToArray(record, " ");
            if (arrayLen(ARGUMENTS.records) > 1) {
                results = [];
                arrayAppend(results, {
                    "primaryNS" = reReplace(zoneSplit[1], "\.$", "", "ALL"),
                    "email" = reReplace(zoneSplit[2], "\.$", "", "ALL"),
                    "domainSerial" = zoneSplit[3],
                    "timers" = [zoneSplit[4], zoneSplit[5], zoneSplit[6], zoneSplit[7]]
                });
            } else {
                results = {
                    "primaryNS" = reReplace(zoneSplit[1], "\.$", "", "ALL"),
                    "email" = reReplace(zoneSplit[2], "\.$", "", "ALL"),
                    "domainSerial" = zoneSplit[3],
                    "timers" = [zoneSplit[4], zoneSplit[5], zoneSplit[6], zoneSplit[7]]
                };
            }
        }

        return results;
    }
}