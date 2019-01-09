#!/usr/bin/perl

use warnings;

sub clean_line
{
  my $l = shift;
  chomp($l);
  $l =~ s/ //g;
  $l =~ s/\]$//;
  $l =~ s/^\[//;
  return $l;
}


sub process_output_bytes
{
  my ($lines_r, $i, $l) = (shift, shift, "");
  my @bytes = ();

  while($i++ <= $#$lines_r)
  {
    $l = clean_line($lines_r->[$i-1]);
    push @bytes, $_ foreach (split ';', $l);
    if($lines_r->[$i-1] =~ m/(.+)\]$/)
    { return (\@bytes, $i); }
  }
  return (\@bytes, $i); # only for the case where there isn't a ]
}


sub process_output
{
  my ($lines_r, $i, $bytes_r) = (shift, shift, 0);
  my @list = ();

  while($i++ <= $#$lines_r)
  { if($lines_r->[$i-1] =~ m/^\[/)
    { ($bytes_r, $i) = process_output_bytes($lines_r, $i-1);
      push @list, $bytes_r; }
  }
  return (\@list, $i);
}


sub process_lines
{
  my ($lines_r, $i) = (shift, 0);
  my %eval = ();

  while ($i++ <= $#$lines_r)
  { if($lines_r->[$i-1] =~ m/Evaluation of (.+):/)
    { ($eval{$1}, $i) = process_output($lines_r, $i); }
  }
  %eval;
}


sub pad_u8
{
#  return @_;
  my @bytes = @_;
  my $i = 0;

  while($i++ <= $#bytes)
  { if(length $bytes[$i-1] == 1)
    { $bytes[$i-1] = '0'. $bytes[$i-1]; }
  }

 return @bytes;
}

sub get_u32
{
  my ($bytes_r, $i) = @_;
  return ("0x" . (join '', pad_u8(reverse @$bytes_r[$i..$i+3])), $i+4);
}

sub get_u64
{
  my ($bytes_r, $i) = @_;
  return ("0x" . (join '', pad_u8(reverse @$bytes_r[$i..$i+7])), $i+8);
}

sub get_u32s
{
  my ($bytes_r, $i, $s) = (shift, 0, "");
  my @u32s = ();

  while ($i<=$#$bytes_r)
  { ($s, $i) = get_u32($bytes_r, $i);
    push @u32s, $s;
  }

  return \@u32s;
}

sub get_u64s
{
  my ($bytes_r, $i, $s) = (shift, 0, "");
  my @u64s = ();

  while ($i<=$#$bytes_r)
  { ($s, $i) = get_u64($bytes_r, $i);
    push @u64s, $s;
  }

  return \@u64s;
}


sub dump_u256_as_u32s
{
  my ($bytes_r, $u64s, $i) = (shift, 0, 0);
  $u32s = get_u32s($bytes_r);
  while($i++ <= $#$u32s)
  { if($i != 1 && ($i-1) % 8 == 0)
    { print "\n"; }
    print ", $u32s->[$i-1]";
  }
  print "\n\n";
}


sub dump_u256_as_u64s
{
  my ($bytes_r, $u64s, $i) = (shift, 0, 0);
  $u64s = get_u64s($bytes_r);
  while($i++ <= $#$u64s)
  { if($i != 1 && ($i-1) % 4 == 0)
    { print "\n"; }
    print ", $u64s->[$i-1]";
  }
  print "\n\n";
}


sub dump_u128_as_u64s
{
  my ($bytes_r, $u64s, $i) = (shift, 0, 0);
  $u64s = get_u64s($bytes_r);
  while($i++ <= $#$u64s)
  { if($i != 1 && ($i-1) % 2 == 0)
    { print "\n"; }
    print ", $u64s->[$i-1]";
  }
  print "\n\n";
}


sub dump_eval
{
  my $eval_r = shift;
  foreach my $k (keys %$eval_r)
  { print "$k\n";
    dump_u256_as_u32s($_) foreach (@{$eval_r->{$k}});
    #dump_u256_as_u64s($_) foreach (@{$eval_r->{$k}});
    #dump_u128_as_u64s($_) foreach (@{$eval_r->{$k}});
  }
}

# main
my @lines = ();
push @lines, $_ foreach(<>);
my %eval = process_lines(\@lines);
dump_eval(\%eval);

