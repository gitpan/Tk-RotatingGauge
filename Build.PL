
use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
  module_name   => 'Tk::RotatingGauge',
  license       => 'perl',
  dist_abstract => "a\ rotating\ gauge\ for\ tk",
  dist_name     => "Tk\-RotatingGauge",
  dist_author   => [
"Jerome\ Quelin",
  ],
  requires      => {
    "DateTime" => '0',
    "base" => '0',
    "English" => '0',
    "FindBin" => '0',
    "Time::HiRes" => '0',
    "Test::More" => '0',
    "Tk::Canvas" => '0',
    "POSIX" => '0',
    "File::Find" => '0',
    "Tk" => '0',
  },
  script_files => [ qw() ],
);

$build->create_build_script;
