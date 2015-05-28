# ntppcap

report of NTP clients

Requires the perl libraries Net::Pcap and NetPacket

Example usage:

	$ sudo ./ntptop --ipv4=$MY_IPV4_ADDRESS --ipv6=$MY_IPV6_ADDRESS --subnets
	p:1 c:1 a:1.0
	p:7 c:7 a:1.0
	p:98 c:86 a:1.1
	[... 60 seconds worth ...]
	p:5140 c:2854 a:1.8
	[63.143.114.]:247 [63.143.115.]:86 [172.56.5.]:74 [172.56.4.]:67 [208.54.44.]:36 
	[66.102.229.]:32 [108.61.25.]:24 [166.173.186.]:21 [216.14.82.]:13 
	[2600:1008:b125:bcf::]:12 

The --subnets argument summarizes the clients into /24 (IPv4) and /64 (IPv6) subnets. 

This program shows the top 10 sources every minute, and every second shows a line with: "p" - packets, "c" - clients (really unique source IPs or Subnets), and "a" - average packets per unique source IP

Defaults:

 * interface = eth0
 * filter = port 123 and udp

--ipv4 and --ipv6 options change the filter to remove the reply traffic from the report
