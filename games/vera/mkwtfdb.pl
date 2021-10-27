#!/usr/bin/perl -w

# mkwtfdb.pl: create wtf(6) compatible acronym database from vera source.
# part of slackbuilds.org vera SlackBuild.
# by B. Watson, licensed under WTFPL.

$dir = shift || ".";
chdir $dir || die "$0: $dir: $!\n";

@output = ();

for $ext (0, 'a'..'z') {
	open(my $f, "<vera.$ext") or next;
	my ($acronym, $definition);

	while(<$f>) {
		last if /^\@table/;
	}

	while(<$f>) {
		chomp;
		last if /^\@end/;

		if(/^\@item\s+(\w+)/) {
			$acronym = $1;
			undef $definition;
		} elsif(/^\s*$/) {
			push @output, "$acronym\t$definition\n";
			undef $acronym;
		} else {
			$definition .= $_;
		}
	}
}

while(<DATA>) {
	push @output, $_;
}

print sort { $a cmp $b } @output;

# Rest of this file is the original contents of /usr/share/misc/acronyms
# from Slack 14.1's bsd-games (minus the comment and blank line at the top).

__DATA__
AFAICR	as far as I can recall
AFAICT	as far as I can tell
AFAIK	as far as I know
AFAIR	as far as I recall
AFK	away from keyboard
AIUI	as I understand it
AKA	also known as
ASAP	as soon as possible
AWOL	absent without official leave
AYBABTU	all your base are belong to us
BBL	[I'll] be back later
BBS	be back soon
BBT	be back tomorrow
BFD	big fucking deal
BIAB	back in a bit
BIAF	back in a few
BIALW	back in a little while
BIAS	back in a second
BIAW	back in a while
BOFH	bastard operator from hell
BOHICA	bend over here it comes again
BRB	[I'll] be right back
BTDT	been there, done that
BTTH	butt to the head
BTW	by the way
CMIIW	correct me if I'm wrong
CNP	continued [in my] next post
CYA	see you around
DNDK	don't know, don't care
DTRT	do the right thing
DTWT	do the wrong thing
DWIM	do what I mean
EG	evil grin
EMSG	email message
ETLA	extended three letter acronym
EWAG	experienced wild-ass guess
FAQ	frequently asked question
FIIK	fuck[ed] if I know
FIIR	fuck[ed] if I remember
FOAD	fall over and die
FSDO	for some definition of
FSVO	for some value of
FUBAR	fucked up beyond all recognition
FUD	fear, uncertainty and doubt
FWIW	for what it's worth
FYI	for your information
G	grin
GMTA	great minds think alike
HAND	have a nice day
HHIS	hanging head in shame
HTH	hope this helps
IANAL	I am not a lawyer
IHAFC	I haven't a fucking clue
IHNFC	I have no fucking clue
IIANM	if I am not mistaken
IIRC	if I recall correctly
IMCO	in my considered opinion
IMHO	in my humble opinion
IMNSHO	in my not so humble opinion
IMO	in my opinion
IOW	in other words
IRL	in real life
ISTM	it seems to me
ISTR	I seem to recall
ITYM	I think you mean
JIC	just in case
JK	just kidding
JMO	just my opinion
JTLYK	just to let you know
KISS	keep it simple, stupid
KITA	kick in the ass
KNF	kernel normal form
L8R	later
LART	luser attitude readjustment tool (ie, hammer)
LJBF	let's just be friends
LMSO	laughing my socks off
LOL	laughing out loud
LTNS	long time no see
MOTAS	member of the appropriate sex
MOTOS	member of the opposite sex
MOTSS	member of the same sex
MTF	more to follow
MYOB	mind your own business
NBD	no big deal
NFC	no fucking clue
NFI	no fucking idea
NFW	no fucking way
NIH	not invented here
NP	no problem
NRFPT	not ready for prime time
NRN	no reply necessary
OIC	oh, I see
OTL	out to lunch
OTOH	on the other hand
OTTOMH	off the top of my head
PFY	pimply faced youth
PITA	pain in the ass
PNG	persona non grata
POC	point of contact
POLA	principle of least astonishment
PPL	pretty please
QED	quod erat demonstrandum
RFC	request for comments
RL	real life
RLC	rod length check
ROTFL	rolling on the floor laughing
RP	responsible person
RSN	real soon now
RTFB	read the fine/fucking book
RTFM	read the fine/fucking manual
RTFMP	read the fine/fucking man page
RTFS	read the fine/fucking source
SCNR	sorry, could not resist
SEP	someone else's problem
SFA	sweet fuck all
SHID	slaps head in disgust
SMLSFB	so many losers, so few bullets
SMOP	simple matter of programming
SNAFU	situation normal, all fucked up
SNERT	snot-nosed egotistical rude teenager
SO	significant other
SOB	son of [a] bitch
SOL	shit out [of] luck
SUS	stupid user syndrome
SWAG	silly, wild-assed guess
SWAHBI	silly, wild-assed hare-brained idea
TANSTAAFL	there ain't no such thing as a free lunch
TBD	to be {decided,determined,done}
TIA	thanks in advance
TLA	three letter acronym
TMA	too many abbreviations
TMI	too much information
TTFN	ta ta for now
TTYL	talk to you later
TYVM	thank you very much
UTSL	use the source, Luke
VEG	very evil grin
WAG	wild-ass guess
WIBNI	wouldn't it be nice if
WOFTAM	waste of fucking time and money
WOMBAT	waste of money, brain, and time
WTF	{what,where,who,why} the fuck
WTH	{what,where,who,why} the hell
WYSIWYG	what you see is what you get
YKWIM	you know what I mean
YMMV	your mileage may vary
