/**
* @hint A CFC for retrieving DNS records from a supplied domain.
* The "lookup" functions cover DNS types listed at
* http://en.wikipedia.org/wiki/List_of_DNS_record_types.
* @author Tony Junkes - @cfchef
* @version 1.1
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
    * @hint Returns a array of A record values.
    */
    public array function lookupA()
        output="false"
    {
        return getAttributeByType(dnsType = "A");
    }
    /**
    * @hint Returns a array of AAAA record values.
    */
    public array function lookupAAAA()
        output="false"
    {
        return getAttributeByType(dnsType = "AAAA");
    }
    /**
    * @hint a array of Returns AFSDB record values.
    */
    public array function lookupAFSDB()
        output="false"
    {
        return getAttributeByType(dnsType = "AFSDB");
    }
    /**
    * @hint Returns a array of APL record values.
    */
    public array function lookupAPL()
        output="false"
    {
        return getAttributeByType(dnsType = "APL");
    }
    /**
    * @hint Returns a array of CAA record values.
    */
    public array function lookupCAA()
        output="false"
    {
        return getAttributeByType(dnsType = "CAA");
    }
    /**
    * @hint Returns a array of CERT record values.
    */
    public array function lookupCERT()
        output="false"
    {
        return getAttributeByType(dnsType = "CERT");
    }
    /**
    * @hint Returns a array of CNAME record values.
    */
    public array function lookupCNAME()
        output="false"
    {
        return getAttributeByType(dnsType = "CNAME");
    }
    /**
    * @hint Returns a array of DHCID record values.
    */
    public array function lookupDHCID()
        output="false"
    {
        return getAttributeByType(dnsType = "DHCID");
    }
    /**
    * @hint Returns a array of DLV record values.
    */
    public array function lookupDLV()
        output="false"
    {
        return getAttributeByType(dnsType = "DLV");
    }
    /**
    * @hint Returns a array of DNAME record values.
    */
    public array function lookupDNAME()
        output="false"
    {
        return getAttributeByType(dnsType = "DNAME");
    }
    /**
    * @hint Returns a array of DNSKEY record values.
    */
    public array function lookupDNSKEY()
        output="false"
    {
        return getAttributeByType(dnsType = "DNSKEY");
    }
    /**
    * @hint Returns a array of DS record values.
    */
    public array function lookupDS()
        output="false"
    {
        return getAttributeByType(dnsType = "DS");
    }
    /**
    * @hint Returns a array of HIP record values.
    */
    public array function lookupHIP()
        output="false"
    {
        return getAttributeByType(dnsType = "HIP");
    }
    /**
    * @hint Returns a array of IPSECKEY record values.
    */
    public array function lookupIPSECKEY()
        output="false"
    {
        return getAttributeByType(dnsType = "IPSECKEY");
    }
    /**
    * @hint Returns a array of KEY record values.
    */
    public array function lookupKEY()
        output="false"
    {
        return getAttributeByType(dnsType = "KEY");
    }
    /**
    * @hint Returns a array of KX record values.
    */
    public array function lookupKX()
        output="false"
    {
        return getAttributeByType(dnsType = "KX");
    }
    /**
    * @hint Returns a array of LOC record values.
    */
    public array function lookupLOC()
        output="false"
    {
        return getAttributeByType(dnsType = "LOC");
    }
    /**
    * @hint Returns a array of structs containing MX record values
    * sorted from most preferred to least preferred.
    */
    public array function lookupMX()
        output="false"
    {
        //see: RFC 974 - Mail routing and the domain system.
        //see: RFC 1034 - Domain names - concepts and facilities.
        //see: http://java.sun.com/j2se/1.5.0/docs/guide/jndi/jndi-dns.html -
        //DNS Service Provider for the Java Naming Directory Interface (JNDI).
        var records = getAttributeByType(dnsType = "MX");
        var pvhnSplit = results = [];
        var hostName = record = "";
        var preferenceValue = 0;

        //Split MX RRs into Preference Values(pvhnSplit[1]) and Host Names(pvhnSplit[2]),
        //remove any trailing periods from Host Names and assign to a array of
        //structs containing the split values.
        for (record in records) {
            pvhnSplit = listToArray(record, " ");
            arrayAppend(results, {
                "preferenceValue" = pvhnSplit[1],
                "hostName" = reReplace(pvhnSplit[2], "\.$", "", "ALL")
            });
        }

        return results;
    }
    /**
    * @hint Returns a array of NAPTR record values.
    */
    public array function lookupNAPTR()
        output="false"
    {
        return getAttributeByType(dnsType = "NAPTR");
    }
    /**
    * @hint Returns a array of NS record values.
    */
    public array function lookupNS()
        output="false"
    {
        var records = getAttributeByType(dnsType = "NS");
        var results = [];
        var record = "";

        //remove any trailing periods from NS records.
        for (record in records) {
            arrayAppend(results, reReplace(record, "\.$", "", "ALL"));
        }

        return results;
    }
    /**
    * @hint Returns a array of NSEC record values.
    */
    public array function lookupNSEC()
        output="false"
    {
        return getAttributeByType(dnsType = "NSEC");
    }
    /**
    * @hint Returns a array of NSEC3 record values.
    */
    public array function lookupNSEC3()
        output="false"
    {
        return getAttributeByType(dnsType = "NSEC3");
    }
    /**
    * @hint Returns a array of NSEC3PARAM record values.
    */
    public array function lookupNSEC3PARAM()
        output="false"
    {
        return getAttributeByType(dnsType = "NSEC3PARAM");
    }
    /**
    * @hint Returns a array of PTR record values.
    */
    public array function lookupPTR()
        output="false"
    {
        return getAttributeByType(dnsType = "PTR");
    }
    /**
    * @hint Returns a array of RRSIG record values.
    */
    public array function lookupRRSIG()
        output="false"
    {
        return getAttributeByType(dnsType = "RRSIG");
    }
    /**
    * @hint Returns a array of RP record values.
    */
    public array function lookupRP()
        output="false"
    {
        return getAttributeByType(dnsType = "RP");
    }
    /**
    * @hint Returns a array of SIG record values.
    */
    public array function lookupSIG()
        output="false"
    {
        return getAttributeByType(dnsType = "SIG");
    }
    /**
    * @hint Returns a array of structs containing SOA record values.
    */
    public array function lookupSOA()
        output="false"
    {
        var records = getAttributeByType(dnsType = "SOA");
        var zoneSplit = results = timers = [];
        var primaryNS = email = record = "";
        var domainSerial = 0;

        //Split SOA records into specified keys and values,
        //remove any trailing periods from Host/Domain Names and assign to a array of
        //structs containing the split values.
        for (record in records) {
            zoneSplit = listToArray(record, " ");
            arrayAppend(results, {
                "primaryNS" = reReplace(zoneSplit[1], "\.$", "", "ALL"),
                "email" = reReplace(zoneSplit[2], "\.$", "", "ALL"),
                "domainSerial" = zoneSplit[3],
                "timers" = [zoneSplit[4], zoneSplit[5], zoneSplit[6], zoneSplit[7]]
            });
        }

        return results;
    }
    /**
    * @hint Returns a array of SPF record values.
    */
    public array function lookupSPF()
        output="false"
    {
        return getAttributeByType(dnsType = "SPF");
    }
    /**
    * @hint Returns a array of SRV record values.
    */
    public array function lookupSRV()
        output="false"
    {
        return getAttributeByType(dnsType = "SRV");
    }
    /**
    * @hint Returns a array of SSHFP record values.
    */
    public array function lookupSSHFP()
        output="false"
    {
        return getAttributeByType(dnsType = "SSHFP");
    }
    /**
    * @hint Returns a array of TA record values.
    */
    public array function lookupTA()
        output="false"
    {
        return getAttributeByType(dnsType = "TA");
    }
    /**
    * @hint Returns a array of TKEY record values.
    */
    public array function lookupTKEY()
        output="false"
    {
        return getAttributeByType(dnsType = "TKEY");
    }
    /**
    * @hint Returns a array of TLSA record values.
    */
    public array function lookupTLSA()
        output="false"
    {
        return getAttributeByType(dnsType = "TLSA");
    }
    /**
    * @hint Returns a array of TSIG record values.
    */
    public array function lookupTSIG()
        output="false"
    {
        return getAttributeByType(dnsType = "TSIG");
    }
    /**
    * @hint Returns a array of TXT record values.
    */
    public array function lookupTXT()
        output="false"
    {
        return getAttributeByType(dnsType = "TXT");
    }
    /**
    * @hint Returns a javax.naming.directory.BasicAttribute object of DNS types.
    */
    public any function getAttributes()
        output="false"
    {
        return createObject(
            "java", "javax.naming.directory.InitialDirContext"
        ).getAttributes("dns:/" & VARIABLES.domain, javaCast("null", ""));
    }
    /**
    * @hint Returns a array of values from a given DNS type.
    * @param dnsType (required)
    */
    private array function getAttributeByType(required string dnsType = "")
        output="false"
    {
        var i = 0;
        var records = [];
        //Get the records from the default DNS directory service provider.
        var attribute = getAttributes().get(ARGUMENTS.dnsType);

        if (isDefined("attribute")) {
            //Create a array of records and sort them.
            for (i = 0; i < attribute.size(); i++) {
                arrayAppend(records, attribute.get(i));
            }
            arraySort(records, "textnocase", "asc");
        } else {
            //If there are no records then default to domainName (see: RFC 974).
            arrayAppend(records, VARIABLES.domain);
        }

        return records;
    }
}