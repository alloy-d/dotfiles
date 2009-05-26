#!/usr/bin/env perl
#
# dotfiles.pl
# A script to manage configuration files.
#
use warnings;
use strict;

#use File::Spec;
use Git;

my $git_url = 'git@github.com:lloyda2/dotfiles.git';

my %functions = (
    commit => [\&commit, "Commit all changes."],
    edit => [\&edit, "Edit a configuration file."],
    help => [\&help, "View a help message."],
    install => [\&install, "Install a configuration file to your \$HOME."],
    push => [\&push, "Push commits to GitHub."],
    update => [\&update, "Get latest files from GitHub."],
);

my $action = shift @ARGV;
if (defined($functions{$action})) {
    &{$functions{$action}[0]}
} else {
    &{$functions{'help'}[0]}
}

sub add {
    my $dotfile = shift @ARGV or die "Need a file to process!\n";
    if ($dotfile =~ /^[[:alpha:]]/) { $dotfile = '.' . $dotfile; }

    my $repository = Git->repository();
    $repository->command_noisy('add', $dotfile);
}

sub edit {
    my $dotfile = shift @ARGV or die "Need a file to process!\n";
    if ($dotfile =~ /^[[:alpha:]]/) { $dotfile = '.' . $dotfile; }

    my $editor = defined($ENV{'EDITOR'})? $ENV{'EDITOR'} : 'vim'; 

    system($editor, $dotfile);
}

sub install {
    my $dotfile = shift @ARGV or die "Need a file to process!\n";
    if ($dotfile =~ /^[[:alpha:]]/) { $dotfile = '.' . $dotfile; }

    system('cp', '-v', $dotfile, $ENV{'HOME'});
}

sub commit {
    my $message = shift @ARGV or die "Need a commit message!\n";
    my $repository = Git->repository();
    $repository->command_noisy('commit', '-a', "-m $message");
}

sub push {
    my $repository = Git->repository();
    $repository->command_noisy('push', 'origin', 'master');    
}

sub update {
    my $repository;
    my $need_to_clone = !eval {
        $repository = Git->repository();
    };
    
    if ($need_to_clone) {
        Git::command_noisy('clone', $git_url);
    } else {
        $repository->command_noisy('pull');
    }
}

sub help {
    print <<EOF;
Usage: ./dotfiles.pl operation [file]

Operations:
EOF
    for my $key (keys %functions) {
        print "  $key - $functions{$key}[1]\n";
    }
}
