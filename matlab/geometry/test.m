%% Init
close('all');
clear();
clc();

%% Test Suite
% G2
% run(testsuite('./tests/G2Test.m'));
suite = testsuite('./tests/G2Test.m');
run(suite(end));
% G3
% run(testsuite('./tests/G3Test.m'));
% suite = testsuite('./tests/G3Test.m');
% run(suite(end));