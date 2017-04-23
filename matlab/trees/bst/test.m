%%
close('all');
clear();
clc();

%% Run the last `unit test`
suite = testsuite('./tests/TestBST.m');
run(suite(end));
