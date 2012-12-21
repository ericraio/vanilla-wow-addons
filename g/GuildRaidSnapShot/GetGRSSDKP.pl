#perl2exe_include "Tk.pm";
#perl2exe_include "Tk/DialogBox.pm"
##perl2exe_include "File/BSDGlob.pm"
##perl2exe_include "Compress/Bzip2.pm"

use Tk;
require LWP::UserAgent;



my $message = "";
my $url = "http://demo.dkpsystem.com";
open(IN,"<url.txt");
$url = <IN>;
close(IN);
my $myversion;
open(IN,"<GuildRaidSnapShot.toc");
	while(<IN>){
		if(/Version (\S+)/i){
			$myversion = $1;
		}
	}
close(IN);

my $mw = MainWindow->new;
$mw->title("GRSS DKP Downloader");
$mw->Label(-text => "DKPSystem.com's GuildRaidSnapShot DKP Downloader",-foreground=>"darkred",-relief=>"groove")->pack;
$mw->Label(-text => "Enter the URL of your website")->pack;
$mw->Entry(-textvariable => \$url,-background=>"white",-width=>"30")->pack;
$mw->Label(-textvariable => \$message)->pack;
$mw->Button(-text => "Cancel",-width=>10,-command => sub {exit})->pack(-side=>"left",-anchor=>"s");
$mw->Button(-text => "OK",-width=>10,-command => sub {&downloadfile($url)})->pack(-side=>"right",-anchor=>"s");
MainLoop;

sub downloadfile
{
	my $newurl = $_[0];
	$newurl = lc($newurl);
	if($newurl =~ /^(?:http:\/\/)?([a-zA-Z0-9\.\-]+)/){
		$newurl = "http://$1/luadkp.php";
		$url = $1;
	}
	$message = "Downloading $newurl";

	my $ua = LWP::UserAgent->new;
	$ua->timeout(25);
	$ua->env_proxy;

	my $response = $ua->get($newurl);

	if ($response->is_success) {
		open(OUT,">url.txt");
		print OUT $url;
		close(OUT);
		open(OUT,">GRSS_Data.lua");
		print OUT $response->content; 
		close(OUT);
		$mw->Dialog(-title => "Downloaded!",-text => "The download was a success.  Simply type /console reloadui in WoW, or close WoW and reopen it.", -buttons => ['OK'])->Show();
		#print "checking version my version $myversion\n";
		my $version = $ua->get("http://www.dkpsystem.com/grssversion");
		if($version->is_success){
			#print "Current Version ".$version->content."\n";
			if($version->content != $myversion){
				$newversion = $version->content;
				$newversion =~ s/\n//gs;
				my $yesno=$mw->Dialog(-title => "New Version!!",-text => "Would you like GRSS to Automatically download the new version '$newversion' for you?", -default_button => "Yes", -buttons => ['Yes','No'])->Show();
				if($yesno =~ /Yes/){
					&downloadpatch($ua);
				}
			}
		}
		exit;
	}else{
		$mw->Dialog(-title => "Not Good...",-text => "Unfortunately, the URL entered didn't work.  Make sure you have it entered properly and try again", -buttons => ['OK'])->Show();
	}
}

sub downloadpatch
{
	my $prefix = "http://www.dkpsystem.com/files/GRSS";
	my $ua = $_[0];
	my $status;
	$status=&downloadindependentfile("$prefix/GuildRaidSnapShot.lua","GuildRaidSnapShot.lua",$ua);
	$status=&downloadindependentfile("$prefix/GuildRaidSnapShot.toc","GuildRaidSnapShot.toc",$ua) if($status);
	$status=&downloadindependentfile("$prefix/readme.txt","readme.txt",$ua) if($status);
	$status=&downloadindependentfile("$prefix/GuildRaidSnapShot.xml","GuildRaidSnapShot.xml",$ua) if($status);
	$status=&downloadindependentfile("$prefix/GRSSWaitingInvite.xml","GRSSWaitingInvite.xml",$ua) if($status);
	if($status){
		$mw->Dialog(-title => "Successful",-text => "Patch downloaded successfully", -buttons => ['OK'])->Show();
	}else{
		my $yesno=$mw->Dialog(-title => "Upgrade Failed!",-text => "Patch download Failed! Try Again?", -default_button => "Yes",-buttons => ['Yes','No'])->Show();
		if($yesno =~ /Yes/){
			&downloadpatch($ua);
		}
	}
}


sub downloadindependentfile
{
	my $newurl = $_[0];
	my $localfilename = $_[1];
	my $ua = $_[2];
	$message = "Downloading $newurl";

	my $ua = LWP::UserAgent->new;
	$ua->timeout(25);
	$ua->env_proxy;

	my $response = $ua->get($newurl);

	if ($response->is_success) {
		open(OUT,">$localfilename");
		print OUT $response->content; 
		close(OUT);
		return 1;
	}else{
		return 0;
	}
}
