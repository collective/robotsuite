Python unittest test suite for Robot Framework
==============================================

This is an experimental package
for wrapping Robot Framework test suites into Python unittest suites
to make it possible to run Robot Framework tests
as `plone.testing`_'s layered test suites:

.. code:: python

    import unittest

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

.. image:: https://github.com/collective/robotsuite/actions/workflows/build.yml/badge.svg?branch=master
   :target: https://github.com/collective/robotsuite/actions


Setting robot variables from environment variables
--------------------------------------------------

Robot Framework supports overriding test variables from command-line, which
is not-available when running tests as robotsuite-wrapped with other test
runners. That's why robotsuite supports settings variables as environment
variables so that every ``ROBOT_``-prefixed environment variable will be
mapped into corresponding test variable without the ``ROBOT_``-prefix.


Declaring tests non-critical by given set of tags
-------------------------------------------------

.. note:: Criticality is no-longer supported in Robot Framework >= 4.0 and has been
   replaced with SKIP status. Robotsuite does not take a stance on SKIP status yet.

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
-----------------------------

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


Retry failing tests
-------------------

You can retry a failed test.
This can be useful for flaky robot browser tests.
Warning: this may not be good for all types of test.
For example any changes that were done in the test until the first failure, may persist.

You can enable retries in two ways:

- Set an environment variable ``ROBOTSUITE_RETRY_COUNT=X``.

- Override this by passing ``retry_count=X`` to a ``RobotTestSuite`` call.

The default is zero: no retries.
The retry count *excludes* the original try.

.. code:: python

    def test_suite():
        suite = unittest.TestSuite()
        suite.addTests([
            robotsuite.RobotTestSuite('test_example.robot', retry_count=3),
            robotsuite.RobotTestSuite('test_variables.robot'),
            robotsuite.RobotTestSuite('test_setups', retry_count=2)
        ])
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


Filtering test execution errors
-------------------------------

Set environment variable ``ROBOTSUITE_LOGLEVEL=ERROR`` to filter all top level
*Test Execution Errors* below the given log level (e.g. ERROR) from the merged
test report. This is useful when unnecessary warnings are leaking from the
tested code into Robot Framework logs.


Including or skipping all RobotTestSuite-wrapped tests
------------------------------------------------------

Robot Framework is often used with Selenium2Library_ to write acceptance test
using the Selenium-framework. Yet, because those test may be slow to run, one
might want sometimes (e.g. on CI) to run everything except the robotsuite
wrapped tests, and later only the robotsuite wrapped tests.

This can be achieved for sure, with injecting a custom string into the names
of robotsuite-wrapped tests with ``ROBOTSUITE_PREFIX``-environment variable
and then filter the test with that string.

E.g. run everything except the robotsuite wrapped tests with:

.. code:: bash

   $ ROBOTSUITE_PREFIX=ROBOTSUITE bin/test --all -t \!ROBOTSUITE

and the other way around with:

.. code:: bash

   $ ROBOTSUITE_PREFIX=ROBOTSUITE bin/test --all -t ROBOTSUITE

.. _Selenium2Library: https://pypi.python.org/pypi/robotframework-selenium2library



Re-using test suites from other packages
----------------------------------------

Sometime it could be useful to re-use acceptance test from some upstream
package to test your slightly tailored package (e.g. with a custom theme).
This can be done with by defining the test lookup location with
``package``-keyword argment for ``RobotTestSuite``:

.. code:: python

    def test_suite():
        suite = unittest.TestSuite()
        suite.addTests([
            layered(leveled(
                robotsuite.RobotTestSuite('robot',
                                          package='Products.CMFPlone.tests'),
            ), layer=PLONE_APP_MOSAIC_NO_PAC_ROBOT),
        ])
        return suite
