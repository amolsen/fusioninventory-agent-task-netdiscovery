package FusionInventory::Agent::Task::NetDiscovery::Manufacturer::Epson;

use strict;
use warnings;

sub discovery {
    my ($description, $session) = @_;

    if ($description =~ m/EPSON Built-in/) {
        my $description_new = $session->snmpGet({
            oid => '.1.3.6.1.4.1.1248.1.1.3.1.3.8.0',
            up  => 1,
        });
        if ($description_new) {
            $description = $description_new;
        }
    }

    if ($description =~ m/EPSON Internal 10Base-T/) {
        my $description_new = $session->snmpGet({
            oid => '.1.3.6.1.2.1.25.3.2.1.3.1',
            up  => 1,
        });
        if ($description_new) {
            $description = $description_new;
        }
    }
    return $description;
}

1;
