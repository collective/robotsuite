Python unittest test suite for Robot Framework
==============================================

This is an experimental package
for wrapping Robot Framework test suites into Python unittest suites
to make it possible to run Robot Framework tests
as `plone.testing`_'s layered test suites::

    import unittest2 as unittest

    from plone.testing import layered
    from robotsuite import RobotTestSuite

    from my_package.testing import ACCEPTANCE_TESTING


    def test_suite():
        suite = unittest.TestSuite()
        suite.addTests([
            layered(RobotTestSuite('mysuite.txt'),
                    layer=ACCEPTANCE_TESTING),
        ])
        return suite

*RobotTestSuite* splits Robot Framework test suites into separate
unittest test cases so that Robot will be run once for every test
case in every test suite parsed from the given Robot Framework
test suite.
Because of that, each Robot will generate a separate test report
for each test.
Each report will have it's own folder,
which are created recursively
reflecting the structure of the given test suite.

*RobotTestSuite*'s way of wrapping tests into
unittest's test suite is similar to how doctest-module's
DocTestSuite does its wrappings.

The main motivation behind this package is to make
Robot Framework support existing test fixtures and test isolation
when testing `Plone`_.
Yet, this should help anyone wanting to use Robot Framework with
`zope.testrunner`_ or other Python unittest compatible test runner.

.. _plone.testing: http://pypi.python.org/pypi/plone.testing
.. _zope.testrunner: http://pypi.python.org/pypi/zope.testrunner
.. _Plone: http://pypi.python.org/pypi/Plone

If this works for you, please contribute at:
http://github.com/collective/robotsuite/

.. image:: https://secure.travis-ci.org/collective/robotsuite.png
    :target: http://travis-ci.org/collective/robotsuite
