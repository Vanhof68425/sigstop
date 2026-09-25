# eps3.3_service-desk.svc

Seventy-one hours left on node 07.

Last night you learned that your jobs belong to your shell. Close the
terminal and they die. So ask the obvious question: what keeps
everything *else* alive? The copier ran for months. Somebody, or
something, has been holding it up.

Every Linux machine has an answer to that question, and it's always
the same process. The first one. PID 1. The kernel starts it before
anything else, and it starts everything that comes after. On this
node, and on almost every server you will ever touch, PID 1 is called
**systemd**. Its job is to be the manager.

The programs it manages are called *services*. Each one is described
by a small text file called a *unit*: what to run, as which user, and
what to do if it falls over. That last part is the one that matters
tonight. A unit can say `Restart=always`. It means: if this program
dies, for any reason, start it again. Don't ask anyone. Just do it.

Think about what that means for everything you learned last night.
You can send a service all the signals you want. The manager is
watching, and the manager doesn't care what you meant.

There's a service on this node called `prom-evald`. It isn't in any
Apex runbook. I've never seen a unit like this before, and I've read
a lot of their units.

Tonight you learn to talk to the manager instead of the process.

Click **START**.
