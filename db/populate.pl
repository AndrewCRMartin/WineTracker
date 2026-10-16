#!/usr/bin/perl

use strict;
use Text::CSV;
use DBI;

my $dbname = "winetracker";
my $dbhost = "db";
my $dbsource = "dbi:Pg:dbname=$dbname;host=$dbhost";

my $dbh = DBI->connect($dbsource,
                       '', #$username,
                       '', #$password,
                       {AutoCommit => 1, RaiseError => 1, PrintError => 0}
                      );

if(!$dbh)
{
    print "Unable to connect to database\n";
    exit 1;
}

my $csv = Text::CSV->new();           # create a new object

my $nColumns = 0;

my @headers = ();
$_ = <>;                              # Read header
if($csv->parse($_))
{
    @headers = $csv->fields();         # get the parsed fields
    $nColumns = scalar(@headers);
}
else
{
    my $error = $csv->error_input;
    print("Parsing of header line failed on argument: $error\n");
    exit 1;
}

my $linenum = 1;
while(<>)
{
    $linenum++;
    if($csv->parse($_))
    {
        my @columns = $csv->fields();     # get the parsed fields
        ProcessRow($dbh, \@headers, \@columns);
    }
    else
    {
        my $error = $csv->error_input;
        print("Parsing of line $linenum failed on argument: $error\n");
        exit 1;
    }
}

sub ProcessRow
{
    my($dbh, $aHeaders, $aColumns) = @_;
    my $nColumns = scalar(@$aHeaders);

    my $statusID     = 0;
    my $producerID   = 0;
    my $winenameID   = 0;
    my $typeID       = 0;
    my $locationID   = 0;
    my $statusID     = 0;
    my $regionID     = 0;
    my $vendorID     = 0;
    my $collectionID = 0;
    my $sizeID       = 0;

    my $bottles      = 0;
    my $price        = 0;
    my $cprice       = 0;
    my $vintage      = '';
    my $updated      = '';
    my $bracket      = '';
    my $drink        = '';
    my $notes        = '';
    my $scores       = '';

    for(my $col = 0; $col<$nColumns; $col++)
    {
        # Entries in other tables
        if($$aHeaders[$col] eq 'SIZE')
        {
            $sizeID = ProcessSize($dbh, $$aColumns[$col]);
            next;
        }
        if($$aHeaders[$col] eq 'STATUS')
        {
            $statusID = ProcessStatus($dbh, $$aColumns[$col]);
            next;
        }
        if($$aHeaders[$col] eq 'PRODUCER')
        {
            $producerID = ProcessProducer($dbh, $$aColumns[$col]);
            next;
        }
        if($$aHeaders[$col] eq 'REGION')
        {
            $regionID = ProcessRegion($dbh, $$aColumns[$col]);
            next;
        }
        if($$aHeaders[$col] eq 'TYPE')
        {
            $typeID = ProcessType($dbh, $$aColumns[$col]);
            next;
        }
        if($$aHeaders[$col] eq 'WINENAME')
        {
            $winenameID = ProcessWinename($dbh, $$aColumns[$col]);
            next;
        }
        if($$aHeaders[$col] eq 'VENDOR')
        {
            $vendorID = ProcessVendor($dbh, $$aColumns[$col]);
            next;
        }

        # Entries in the main collection table
        if($$aHeaders[$col] eq 'BRACKET')
        {
            $bracket = $$aColumns[$col];
            next;
        }
        if($$aHeaders[$col] eq 'VINTAGE')
        {
            $vintage = $$aColumns[$col];
            next;
        }
        if($$aHeaders[$col] eq 'DRINK')
        {
            $drink = $$aColumns[$col];
            next;
        }
        if($$aHeaders[$col] eq 'NUMBER')
        {
            $bottles = $$aColumns[$col];
            $bottles = 0 if($bottles eq '');
            next;
        }
        if($$aHeaders[$col] eq 'PRICE')
        {
            $price = $$aColumns[$col];
            $price = 0.0 if($price eq '');
            next;
        }
        if($$aHeaders[$col] eq 'CPRICE')
        {
            $cprice = $$aColumns[$col];
            $cprice = 0.0 if($cprice eq '');
            next;
        }
        if($$aHeaders[$col] eq 'SCORE')
        {
            $scores = $$aColumns[$col];
            next;
        }
        if($$aHeaders[$col] eq 'NOTES')
        {
            $notes = $$aColumns[$col];
            next;
        }
        if($$aHeaders[$col] eq 'UPDATED')
        {
            $updated = $$aColumns[$col];
            next;
        }
    }
    InsertToCollection($dbh, $statusID, $producerID, $winenameID,
                       $sizeID, $typeID, $locationID, $statusID,
                       $regionID, $vendorID, $collectionID,
                       $bottles, $vintage, $price, $cprice,
                       $updated, $bracket, $drink, $notes, $scores);
}


sub CheckName
{
    my($dbh, $table, $pkey, $field, $string) = @_;
    my $sql = '';
    if($field eq $pkey)
    {
        $sql = "SELECT $pkey FROM $table WHERE $field = $string";
    }
    else
    {
        $string =~ s/\'/\'\'/g;
        $sql = "SELECT $pkey FROM $table WHERE $field = '$string'";
    }

    # Get the primary key if this string is present in the specified column
    my ($pkeyVal) = $dbh->selectrow_array($sql);

    # If it's not present find the current maximum key
    if($pkeyVal eq '')
    {
        $sql = "SELECT MAX($pkey) FROM $table";
        ($pkeyVal) = $dbh->selectrow_array($sql);
        $pkeyVal = 0 if($pkeyVal eq '');
        $pkeyVal++;
        $sql = "INSERT INTO $table ($pkey, $field) VALUES ($pkeyVal, '$string')";
        $dbh->do($sql);
    }

    return($pkeyVal);
}

        
sub ProcessStatus
{
    my($dbh, $datum) = @_;
    my $pkeyVal = CheckName($dbh, 'status', 'statusid', 'statusid', $datum);
    return($pkeyVal);
}
sub ProcessSize
{
    my($dbh, $datum) = @_;
    my $pkeyVal = CheckName($dbh, 'sizes', 'sizeid', 'sizeid', $datum);
    return($pkeyVal);
}
sub ProcessRegion
{
    my($dbh, $datum) = @_;
    my $pkeyVal = CheckName($dbh, 'region', 'regionid', 'name', $datum);
    return($pkeyVal);
}
sub ProcessProducer
{
    my($dbh, $datum) = @_;
    my $pkeyVal = CheckName($dbh, 'producers', 'prodid', 'name', $datum);
    return($pkeyVal);
}
sub ProcessType
{
    my($dbh, $datum) = @_;
    my $pkeyVal = CheckName($dbh, 'types', 'typeid', 'name', $datum);
    return($pkeyVal);
}
sub ProcessWinename
{
    my($dbh, $datum) = @_;
    my $pkeyVal = CheckName($dbh, 'winenames', 'winenameid', 'name', $datum);
    return($pkeyVal);
}
sub ProcessVendor
{
    my($dbh, $datum) = @_;
    my $pkeyVal = CheckName($dbh, 'vendor', 'vendorid', 'name', $datum);
    return($pkeyVal);
}


sub InsertToCollection
{
    my($dbh, $statusID, $producerID, $winenameID,
       $sizeID, $typeID, $locationID, $statusID,
       $regionID, $vendorID, $collectionID,
       $bottles, $vintage, $price, $cprice,
       $updated, $bracket, $drink, $notes, $scores) = @_;

    my $sql = "SELECT MAX(collectionid) FROM collection";
    my ($collectionID) = $dbh->selectrow_array($sql);
    $collectionID = 0 if($collectionID eq '');
    $collectionID++;
    $sql = <<__EOF;
    INSERT INTO collection (collectionid, winenameid, typeid, sizeid, locid, statusid,
                            prodid, regionid, vendorid, bottles, vintage, price, cprice,
                            updated, bracket, drink, notes, scores)
        VALUES($collectionID, $winenameID, $typeID, $sizeID, $locationID, $statusID, 
               $producerID, $regionID, $vendorID, $bottles, '$vintage', $price, $cprice,
               '$updated', '$bracket', '$drink', '$notes', '$scores')
__EOF

    $dbh->do($sql);
}
