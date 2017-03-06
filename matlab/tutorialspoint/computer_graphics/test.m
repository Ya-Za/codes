close('all');
clear();
clc();

% Test Suite
import('matlab.unittest.TestSuite');
run(TestSuite.fromFolder('tests'));