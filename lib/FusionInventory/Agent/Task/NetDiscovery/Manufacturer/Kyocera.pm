package FusionInventory::Agent::Task::NetDiscovery::Manufacturer::Kyocera;

use strict;
use warnings;

sub discovery {
    my ($description, $session) = @_;

    if ($description =~ m/,HP,JETDIRECT,J/) {
        my $description_new = $session->snmpGet({
            oid => '.1.3.6.1.4.1.1229.2.2.2.1.15.1',
            up  => 1,
        });
        if ($description_new) {
            $description = $description_new;
        }
    } elsif (($description eq "KYOCERA MITA Printing System") || ($description eq "KYOCERA Printer I/F") || ($description eq "SB-110")) {
        my $description_new = $session->snmpGet({
            oid => '.1.3.6.1.4.1.1347.42.5.1.1.2.1',
            up  => 1,
        });
        if ($description_new) {
            $description = $description_new;
        } else {
            my $description_new = $session->snmpGet({
                oid => '.1.3.6.1.4.1.1347.43.5.1.1.1.1',
                up  => 1,
            });
            if ($description_new) {
                $description = $description_new;
            } else {
                my $description_new = $session->snmpGet({
                    oid => '.1.3.6.1.4.1.1347.43.5.1.1.1.1',
                    up  => 1,
                });
                if ($description_new) {
                    $description = $description_new;
                } else {
                    my $description_new = $session->snmpGet({
                        oid => '.1.3.6.1.4.1.11.2.3.9.1.1.7.0',
                        up  => 1,
                    });
                    if ($description_new) {
                        my @infos = split(/;/,$description_new);
                        foreach (@infos) {
                            if ($_ =~ /^MDL:/) {
                                $_ =~ s/MDL://;
                                $description = $_;
                                last;
                            } elsif ($_ =~ /^MODEL:/) {
                                $_ =~ s/MODEL://;
                                $description = $_;
                                last;
                            }
                        }
                    }
                }
            }
        }
    }
    return $description;
}

1;
