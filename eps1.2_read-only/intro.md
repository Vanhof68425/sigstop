# eps1.2_read-only.log

You didn't delete anything last time. I know because I checked, and you
know I checked. That's our relationship now. Honesty through surveillance.
It's healthier than most.

Tonight, a reading lesson. Not that kind. Nobody's read to you since you
were a child, and I'm not starting.

Here's the problem: last week you `cat` a file and it fit on your screen.
That was luck. Real files — logs, dumps, incident reports — run to
thousands of lines. `cat` a file like that and it firehoses past you at
the speed of regret. Apex engineers do it constantly. Then they scroll up,
get lost, give up, and write "logs inconclusive" in the postmortem. I've
read their postmortems. "Inconclusive" is Apex for "we didn't look."

Operators read with intent. Three tools:

The **top** of a file tells you what it is — headers, first entries.
The **bottom** tells you what happened last — logs append, so the newest
truth is always at the end. And when the answer is somewhere in the
middle, you don't scroll. You open the file **one page at a time** and
you *search*.

The mirror has an incident file Apex thought was scrubbed. 5,000 lines.

Read it like they couldn't.

Click **START**.
