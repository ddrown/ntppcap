package NetPacket::IPv6;

use strict;
use NetPacket;
use Socket6;

use constant IP_VERSION_IPv6 => 6;     # IP version 6

sub decode {
  my($class, $packet) = @_;

  my($self) = {};

  if (defined($packet)) {
    ($self->{ver_tc1}, $self->{tc2_fl1}, $self->{fl2},
     $self->{"length"}, $self->{"next_header"}, $self->{ttl},
     $self->{src_ip_raw},
     $self->{dest_ip_raw},
     $self->{data}) = unpack('CCnnCCa16a16a*' , $packet);

     # Extract bit fields
     $self->{version} = $self->{ver_tc1} >> 4;	
     $self->{traffic_class} = ($self->{ver_tc1} & 0xf) << 4 | ($self->{tc2_fl1} >> 4);
     $self->{flowlabel} = ($self->{tc2_fl1} & 0xf) << 4 | $self->{fl2};

     # Convert 128 bit addresses
     $self->{src_ip} = inet_ntop(AF_INET6,$self->{src_ip_raw});
     $self->{dest_ip} = inet_ntop(AF_INET6,$self->{dest_ip_raw});
  }

  return bless $self, $class;
}

sub subnet_64 {
  my($self) = @_;

  my $src = $self->{src_ip_raw};
  my $zeros = "\0" x 8;
  $src =~ s/.{8}$/$zeros/;
  return inet_ntop(AF_INET6,$src);
}

1;
