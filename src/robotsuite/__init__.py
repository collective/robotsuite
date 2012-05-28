# -*- coding: utf-8 -*-
"""RobotTestSuite"""

import unittest2 as unittest

import doctest
import robot

last_status = None
last_message = None


# XXX: To be able to filter RobotFramework test cases, we mokneypatch
# robot.TestSuite (imported from robot.running.model.TestSuite) to just
# pass the first datasources as the test suite).

def TestSuite(datasources, settings):
    import robot.running.model
    return robot.running.model.RunnableTestSuite(datasources[0])
setattr(robot, 'TestSuite', TestSuite)


class RobotListener(object):
    """RobotFramework runner listener"""

    def end_test(self, status, message):
        global last_status
        global last_message
        last_status = status
        last_message = message


class RobotTestCase(unittest.TestCase):
    """RobotFramework single test suite"""

    def __init__(self, filename, module_relative=True, package=None, **kw):
        unittest.TestCase.__init__(self)

        filename = doctest._module_relative_path(package, filename)
        suite = robot.parsing.TestCaseFile(source=filename)

        if 'name' in kw:
            tests = suite.testcase_table.tests
            suite.testcase_table.tests =\
                filter(lambda x: x.name == kw['name'], tests)

        self._robot_suite = suite

    def runTest(self):
        robot.run(self._robot_suite,
                  listener=('robotsuite.RobotListener',),
                  log='NONE', report='NONE')
        assert last_status == 'PASS', last_message


def RobotTestSuite(*paths, **kw):
    """Build up a test suite similarly to doctest.DocFileSuite"""

    suite = unittest.TestSuite()
    if kw.get('module_relative', True):
        kw['package'] = doctest._normalize_module(kw.get('package'))

    for path in paths:
        filename = doctest._module_relative_path(kw['package'], path)
        robot_suite = robot.parsing.TestCaseFile(source=filename)
        # split the robot suite into separate test cases
        for test in robot_suite.testcase_table.tests:
            suite.addTest(RobotTestCase(path, name=test.name, **kw))

    return suite
