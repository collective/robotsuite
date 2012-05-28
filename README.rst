Python unittest test suite for Robot Framework
==============================================

This is an experiment to wrap Robot Framework tests into Python
unittest framework to make possible to run Robot Framework tests
with ``zope.testrunner``'s layered test setups, as in::

    from unittest2 as unittest

    from plone.testing import layered
    from robotsuite import RobotTestSuite

    from my.app.testing import FUNCTIONAL_TESTING


    def test_suite():
        suite = unittest.TestSuite()
        suite.addTests([
            layered(RobotTestSuite('mysuite.txt'),
                    layer=FUNCTIONAL_TESTING),
        ])
        return suite

Currently, only single file test suites have been tested. *RobotTestSuite*
splits the test suite into separate unittest test cases so that robot will
be run once for every test in the suite.
