# irssi-notify.pl
use Irssi;
use Net::DBus;

$::VERSION='0.0.1';
%::IRSSI = (
    authors => 'Ashish Shukla',
    contact => 'gmail.com!wahjava',
    name => 'irssi-notify',
    description => 'Displays a pop-up message for message received',
    url => 'http://wahjava.wordpress.com/',
    license => 'GNU General Public License',
    changed => '$Date$'
    );

my $APPNAME = 'irssi';

my $bus = Net::DBus->session;
my $notifications = $bus->get_service('org.freedesktop.Notifications');
my $object = $notifications->get_object('/org/freedesktop/Notifications',
					'org.freedesktop.Notifications');

my $notify_nick = 'abbe';

# $object->Notify('appname', 0, 'info', 'Title', 'Message', [], { }, 3000);

sub print_status {
    my $text = shift;

    open(FILE,">$ENV{HOME}/.irssi_status");
    print FILE $text;
    close (FILE);
}

sub pub_msg {
    my ($server,$msg,$nick,$address,$target) = @_;

    print_status("$target");

    if ($msg =~ $notify_nick)
    {
	$object->Notify("${APPNAME}:${server}",
			0,
			'info',
			"$target",
			"$nick: $msg",
			[], { }, 3000);
    }
}

sub priv_msg {
    my ($server,$msg,$nick,$address) = @_;

    print_status("$nick");

    $object->Notify("${APPNAME}:${server}",
		    0,
		    'info',
		    "$nick",
		    "$msg",
		    [], { }, 3000);
}


sub cmd_notifyon {
    my $nick = shift;

    if(!$nick)
    {
	Irssi::print("Current notification nick is $notify_nick .");
    }
    else
    {
	$notify_nick = $nick;
    }
}

Irssi::signal_add_last('message public', \&pub_msg);
Irssi::signal_add_last('message private', \&priv_msg);
Irssi::signal_add_last('window changed', sub { print_status(""); });
Irssi::command_bind('notify-on', \&cmd_notifyon);
