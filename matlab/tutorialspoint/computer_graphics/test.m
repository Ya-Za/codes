close('all');
clear();
clc();

% Test Suite
% import('matlab.unittest.TestSuite');
% run(TestSuite.fromFolder('tests'));

suite = testsuite('./tests/TestUtils.m');
suite.run();