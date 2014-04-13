Python unittest test suite for Robot Framework
==============================================

This is an experimental package
for wrapping Robot Framework test suites into Python unittest suites
to make it possible to run Robot Framework tests
as `plone.testing`_'s layered test suites:

.. code:: python

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
See the documentation of DocTestSuite for
possible common parameters (e.g. for how to pass a test suite from a
different package).

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


Setting robot variables from environment variables
--------------------------------------------------

Robot Framework supports overriding test variables from command-line, which
is not-available when running tests as robotsuite-wrapped with other test
runners. That's why robotsuite supports settings variables as environment
variables so that every ``ROBOT_``-prefixed environment variable will be
mapped into corresponding test variable without the ``ROBOT_``-prefix.


Declaring tests non-critical by given set of tags
-------------------------------------------------

Robot Framework supports declaring tests with given tags as *non-critical*
to prevent their failing to fail the complete build on CI. This is supported
as keyword argument for *RobotTestSuite* as follows:

.. code:: python

   def test_suite():
       suite = unittest.TestSuite()
       suite.addTests([
           layered(RobotTestSuite('mysuite.txt',
                                  noncritical=['non-critical-tag']),
                   layer=ACCEPTANCE_TESTING),
       ])
       return suite


Setting zope.testrunner-level
---------------------------------

`zope.testrunner`_ supports annotating test suites with levels to avoid
slow test being run unless wanted:

.. code:: python

   def test_suite():
       suite = unittest.TestSuite()
       suite.addTests([
           layered(RobotTestSuite('mysuite.txt'),
                   layer=ACCEPTANCE_TESTING),
       ])
       suite.level = 10
       return suite


Appending test results to existing test report
----------------------------------------------

When running Robot Framework through robotsuite, its test reports are created
into the current working directory with filenames ``robot_output.xml``,
``robot_log.html`` and ``robot_report.html``. The default behavior is to
override the existing ``robot_output.xml`` (and also the other report files
generated from that).

To merge test results from separate test runs into the same test report, set
environment variable ``ROBOTSUITE_APPEND_OUTPUT_XML=1`` to prevent robotsuite
from overriding the existing test results, but to always append to the existing
``robot_output.xml``.
