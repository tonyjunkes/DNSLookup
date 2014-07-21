/**
* @hint A CFC for retrieving DNS records from a supplied domain.
* The "lookup" functions cover DNS types listed at
* http://en.wikipedia.org/wiki/List_of_DNS_record_types.
* Formatting of data has been applied to known outputs that could be tested.
* Some arrays may contain a string of multiple values that need to be parsed.
* @author Tony Junkes - @cfchef
* @version 1.0
*/
component name="DNSLookup"
    output="false"
{
    /**
    * @hint Initialize the object.
    * @param domainName The domain to lookup records from. (required)
    * @return Returns a object for further processing.
    */
    public any function init(required string domainName = "")
        output="false"
    {
        VARIABLES.domain = ARGUMENTS.domainName;

        return THIS;
    }
    /**
    * @hint Returns A record values.
    * @return Returns an array of A records.
    */
    public array function lookupA()
        output="false"
    {
        return getAttributeByType(dnsType = "A");
    }
    /**
    * @hint Returns AAAA record values.
    * @return Returns an array of AAAA records.
    */
    public array function lookupAAAA()
        output="false"
    {
        return getAttributeByType(dnsType = "AAAA");
    }
    /**
    * @hint Returns AFSDB record values.
    * @return Returns an array of AFSDB records.
    */
    public array function lookupAFSDB()
        output="false"
    {
        return getAttributeByType(dnsType = "AFSDB");
    }
    /**
    * @hint Returns APL record values.
    * @return Returns an array of APL records.
    */
    public array function lookupAPL()
        output="false"
    {
        return getAttributeByType(dnsType = "APL");
    }
    /**
    * @hint Returns CAA record values.
    * @return Returns an array of CAA records.
    */
    public array function lookupCAA()
        output="false"
    {
        return getAttributeByType(dnsType = "CAA");
    }
    /**
    * @hint Returns CERT record values.
    * @return Returns an array of CERT records.
    */
    public array function lookupCERT()
        output="false"
    {
        return getAttributeByType(dnsType = "CERT");
    }
    /**
    * @hint Returns CNAME record values.
    * @return Returns an array of CNAME records.
    */
    public array function lookupCNAME()
        output="false"
    {
        return getAttributeByType(dnsType = "CNAME");
    }
    /**
    * @hint Returns DHCID record values.
    * @return Returns an array of DHCID records.
    */
    public array function lookupDHCID()
        output="false"
    {
        return getAttributeByType(dnsType = "DHCID");
    }
    /**
    * @hint Returns DLV record values.
    * @return Returns an array of DLV records.
    */
    public array function lookupDLV()
        output="false"
    {
        return getAttributeByType(dnsType = "DLV");
    }
    /**
    * @hint Returns DNAME record values.
    * @return Returns an array of DNAME records.
    */
    public array function lookupDNAME()
        output="false"
    {
        return getAttributeByType(dnsType = "DNAME");
    }
    /**
    * @hint Returns DNSKEY record values.
    * @return Returns an array of DNSKEY records.
    */
    public array function lookupDNSKEY()
        output="false"
    {
        return getAttributeByType(dnsType = "DNSKEY");
    }
    /**
    * @hint Returns DS record values.
    * @return Returns an array of DS records.
    */
    public array function lookupDS()
        output="false"
    {
        return getAttributeByType(dnsType = "DS");
    }
    /**
    * @hint Returns HIP record values.
    * @return Returns an array of HIP records.
    */
    public array function lookupHIP()
        output="false"
    {
        return getAttributeByType(dnsType = "HIP");
    }
    /**
    * @hint Returns IPSECKEY record values.
    * @return Returns an array of IPSECKEY records.
    */
    public array function lookupIPSECKEY()
        output="false"
    {
        return getAttributeByType(dnsType = "IPSECKEY");
    }
    /**
    * @hint Returns KEY record values.
    * @return Returns an array of KEY records.
    */
    public array function lookupKEY()
        output="false"
    {
        return getAttributeByType(dnsType = "KEY");
    }
    /**
    * @hint Returns KX record values.
    * @return Returns an array of KX records.
    */
    public array function lookupKX()
        output="false"
    {
        return getAttributeByType(dnsType = "KX");
    }
    /**
    * @hint Returns LOC record values.
    * @return Returns an array of LOC records.
    */
    public array function lookupLOC()
        output="false"
    {
        return getAttributeByType(dnsType = "LOC");
    }
    /**
    * @hint Returns a array of MX record values
    * sorted from most preferred to least preferred.
    * @return Returns an array of structs containing host info (if any).
    */
    public array function lookupMX()
        output="false"
    {
        //see: RFC 974 - Mail routing and the domain system.
        //see: RFC 1034 - Domain names - concepts and facilities.
        //see: http://java.sun.com/j2se/1.5.0/docs/guide/jndi/jndi-dns.html -
        //DNS Service Provider for the Java Naming Directory Interface (JNDI).
        var records = pvhnSplit = results = [];
        var hostName = record = "";
        var preferenceValue = 0;

        //Get DNS type records.
        records = getAttributeByType(dnsType = "MX");
        //Split MX RRs into Preference Values(pvhnSplit[1]) and Host Names(pvhnSplit[2]),
        //remove any trailing periods from Host Names and assign to an array of
        //structs containing the split values.
        for (record in records) {
            pvhnSplit = listToArray(record, " ");
            arrayAppend(results, {
                "preferenceValue" = pvhnSplit[1],
                "hostName" = (
                    pvhnSplit[2].endsWith(".")
                    ? pvhnSplit[2].substring(0, pvhnSplit[2].length() - 1)
                    : pvhnSplit[2]
                )
            });
        }

        return results;
    }
    /**
    * @hint Returns NAPTR record values.
    * @return Returns an array of NAPTR records.
    */
    public array function lookupNAPTR()
        output="false"
    {
        return getAttributeByType(dnsType = "NAPTR");
    }
    /**
    * @hint Returns NS record values.
    * @return Returns an array of NS records.
    */
    public array function lookupNS()
        output="false"
    {
        var records = getAttributeByType(dnsType = "NS");
        var results = [];
        var hostName = record = "";
        var preferenceValue = 0;

        //remove any trailing periods from NS records.
        for (record in records) {
            arrayAppend(results, (
                    record.endsWith(".")
                    ? record.substring(0, record.length() - 1)
                    : record
                )
            );
        }

        return results;
    }
    /**
    * @hint Returns NSEC record values.
    * @return Returns an array of NSEC records.
    */
    public array function lookupNSEC()
        output="false"
    {
        return getAttributeByType(dnsType = "NSEC");
    }
    /**
    * @hint Returns NSEC3 record values.
    * @return Returns an array of NSEC3 records.
    */
    public array function lookupNSEC3()
        output="false"
    {
        return getAttributeByType(dnsType = "NSEC3");
    }
    /**
    * @hint Returns NSEC3PARAM record values.
    * @return Returns an array of NSEC3PARAM records.
    */
    public array function lookupNSEC3PARAM()
        output="false"
    {
        return getAttributeByType(dnsType = "NSEC3PARAM");
    }
    /**
    * @hint Returns PTR record values.
    * @return Returns an array of PTR records.
    */
    public array function lookupPTR()
        output="false"
    {
        return getAttributeByType(dnsType = "PTR");
    }
    /**
    * @hint Returns RRSIG record values.
    * @return Returns an array of RRSIG records.
    */
    public array function lookupRRSIG()
        output="false"
    {
        return getAttributeByType(dnsType = "RRSIG");
    }
    /**
    * @hint Returns RP record values.
    * @return Returns an array of RP records.
    */
    public array function lookupRP()
        output="false"
    {
        return getAttributeByType(dnsType = "RP");
    }
    /**
    * @hint Returns SIG record values.
    * @return Returns an array of SIG records.
    */
    public array function lookupSIG()
        output="false"
    {
        return getAttributeByType(dnsType = "SIG");
    }
    /**
    * @hint Returns SOA record values.
    * @return Returns an array of structs containing SOA record values.
    */
    public array function lookupSOA()
        output="false"
    {
        var records = zoneSplit = results = timers = [];
        var primaryNS = email = record = "";
        var domainSerial = 0;

        //Get DNS type records.
        records = getAttributeByType(dnsType = "SOA");
        //Split SOA records into specified keys and values,
        //remove any trailing periods from Host/Domain Names and assign to an array of
        //structs containing the split values.
        for (record in records) {
            zoneSplit = listToArray(record, " ");
            arrayAppend(results, {
                "primaryNS" = (
                    zoneSplit[1].endsWith(".")
                    ? zoneSplit[1].substring(0, zoneSplit[1].length() - 1)
                    : zoneSplit[1]
                ),
                "email" = (
                    zoneSplit[2].endsWith(".")
                    ? zoneSplit[2].substring(0, zoneSplit[2].length() - 1)
                    : zoneSplit[2]
                ),
                "domainSerial" = zoneSplit[3],
                "timers" = [zoneSplit[4], zoneSplit[5], zoneSplit[6], zoneSplit[7]]
            });
        }

        return results;
    }
    /**
    * @hint Returns SPF record values.
    * @return Returns an array of SPF records.
    */
    public array function lookupSPF()
        output="false"
    {
        return getAttributeByType(dnsType = "SPF");
    }
    /**
    * @hint Returns SRV record values.
    * @return Returns an array of SRV records.
    */
    public array function lookupSRV()
        output="false"
    {
        return getAttributeByType(dnsType = "SRV");
    }
    /**
    * @hint Returns SSHFP record values.
    * @return Returns an array of SSHFP records.
    */
    public array function lookupSSHFP()
        output="false"
    {
        return getAttributeByType(dnsType = "SSHFP");
    }
    /**
    * @hint Returns TA record values.
    * @return Returns an array of TA records.
    */
    public array function lookupTA()
        output="false"
    {
        return getAttributeByType(dnsType = "TA");
    }
    /**
    * @hint Returns TKEY record values.
    * @return Returns an array of TKEY records.
    */
    public array function lookupTKEY()
        output="false"
    {
        return getAttributeByType(dnsType = "TKEY");
    }
    /**
    * @hint Returns TLSA record values.
    * @return Returns an array of TLSA records.
    */
    public array function lookupTLSA()
        output="false"
    {
        return getAttributeByType(dnsType = "TLSA");
    }
    /**
    * @hint Returns TSIG record values.
    * @return Returns an array of TSIG records.
    */
    public array function lookupTSIG()
        output="false"
    {
        return getAttributeByType(dnsType = "TSIG");
    }
    /**
    * @hint Returns TXT record values.
    * @return Returns an array of TXT records.
    */
    public array function lookupTXT()
        output="false"
    {
        return getAttributeByType(dnsType = "TXT");
    }
    /**
    * @hint Returns a BasicAttribute object of DNS types and values.
    * @return Returns a javax.naming.directory.BasicAttribute object of attributes.
    */
    private function getAttributes()
        output="false"
    {
        var jInitDirCtx = createObject("java", "javax.naming.directory.InitialDirContext");

        return jInitDirCtx.getAttributes("dns:/" & VARIABLES.domain, javaCast("null", ""));
    }
    /**
    * @hint Returns a array of values from a given DNS type.
    * @param dnsType (required)
    * @return Returns a array of attribute values.
    */
    private array function getAttributeByType(required string dnsType = "")
        output="false"
    {
        var i = 0;
        var records = [];
        //Get the records from the default DNS directory service provider.
        var attribute = getAttributes().get(dnsType);

        if (isDefined("attribute")) {
            //Create an array of records and sort them.
            for (i = 0; i < attribute.size(); i++) {
                arrayAppend(records, attribute.get(i));
            }
            arraySort(records, "text", "asc");
        } else {
            //If there are no records then default to domainName (see: RFC 974).
            arrayAppend(records, VARIABLES.domain);
        }

        return records;
    }
}