# ntppcap

report of NTP clients

Requires the perl libraries Net::Pcap, NetPacket, and Net::Patricia

Example usage, reporting on packets per IPv4 /24 and IPv6 /64

	$ sudo ./ntptop --ipv4=$MY_IPV4_ADDRESS --ipv6=$MY_IPV6_ADDRESS --subnets
	p:1 c:1 a:1.0
	p:7 c:7 a:1.0
	p:98 c:86 a:1.1
	[... 60 seconds worth ...]
	p:5140 c:2854 a:1.8
	[63.143.114.]:247 [63.143.115.]:86 [172.56.5.]:74 [172.56.4.]:67 [208.54.44.]:36 
	[66.102.229.]:32 [108.61.25.]:24 [166.173.186.]:21 [216.14.82.]:13 
	[2600:1008:b125:bcf::]:12 

Example usage, reporting on packets per source ASN (currently IPv4-only)

	$ sudo ./ntptop --ipv4=$MY_IPV4_ADDRESS --ipv6=$MY_IPV6_ADDRESS --asns=asn.subnet-index.2016.12.15.bz2
	p:98 c:86 a:1.1
	[... 60 seconds worth ...]
	p:22574(+345) c:3535(+37) a:6.4
	AS7922 (7922 | US | arin |  | COMCAST-7922 - Comcast Cable Communications, LLC, US):1450 6%
	AS197207 (197207 | IR | ripencc | 2012-09-17 | MCCI-AS , IR):1005 4%


This program shows the top 10 sources every minute, and every second shows a line with: "p" - packets, "c" - clients (really unique source IPs or Subnets or ASNs), and "a" - average packets per unique source IP/Subnet/ASN

Defaults:

 * interface = eth0
 * filter = port 123 and udp

Use the --ipv4 and --ipv6 options to remove the reply traffic from the report

To generate a new asn.subnet-index, get a MRT dump (from route-views, for example) and pass it through [zebra-dump-parser.pl](https://github.com/ddrown/zebra-dump-parser.git) < rib.20161215.2200 > subnet-index
