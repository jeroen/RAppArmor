#load lib
library(RAppArmor)

#current limit
rlimit_as();

#set a hard and soft
rlimit_as(1e9);

#current limit
rlimit_as();

#set separate hard and soft
rlimit_as(1e9, 1e8);

#set hard and soft
rlimit_as(1e9);

#set only soft limit
rlimit_as(soft = 1e7);
rlimit_as(soft = 1e9);

#others
rlimit_core(1e9);
rlimit_data(1e9);
rlimit_fsize(1e9);
rlimit_memlock(10000);
rlimit_msgqueue(1e5);
rlimit_nofile(10);
rlimit_nproc(100);
rlimit_rttime(1e9);
rlimit_sigpending(1e4);
rlimit_stack(1000);

rlimit_cpu(10);
